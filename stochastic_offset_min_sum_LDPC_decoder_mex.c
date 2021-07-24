#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include"mex.h"

#define Iter 20
#define N_LDPC 2048
#define K_LDPC 1723
#define C_LDPC 384
#define inf 16

int NL,CL,i,t,l = 0; // loop variabl

int H[C_LDPC][N_LDPC];
int bit_hat[N_LDPC];
int log_I_V_C[N_LDPC][C_LDPC];
int log_I_C_V[C_LDPC][N_LDPC];
int log_I_V_C_stream[N_LDPC][C_LDPC][16] = {0};
int log_I_C_V_stream[C_LDPC][N_LDPC][16] = {0};
int log_I_V_C_sign[N_LDPC][C_LDPC] = {0};
int log_I_C_V_sign[C_LDPC][N_LDPC] = {0};
double total_bit;
int L = 16;
int L_offset = 2;

int flag = 1;
int check = 0;
int min_value[16] = {1};
int sign_value;

int rand_num[16] =  {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15};

void stochastic_offset_min_sum_LDPC_decoder_mex(double *LLR_in, double *H_in, 
							                    double *LLR_out, double *IterNum_out, double *total_bit_out)
{	
	// initialize Parity Check matrix & log_I_C_V;
	for(CL = 0; CL < C_LDPC; CL++)
	{
		for(NL = 0; NL < N_LDPC; NL++)
		{
			H[CL][NL] = (int) H_in[NL*C_LDPC + CL];
			log_I_C_V[CL][NL] = 0;
            log_I_C_V_sign[CL][NL] = 1;
            for(l = 0;l<inf;l++)
            {
                log_I_C_V_stream[CL][NL][l] = 0;
            }
		}
	}
    total_bit = 0;
    
	// LDPC decoding main loop
	for(t = 0; t <= Iter; t++)
	{		
		if(t == 0)
		{
			flag = 1;
			IterNum_out[0] = t;
			total_bit_out[0] = total_bit;
			for(NL = 0; NL < N_LDPC; NL++)
			{
				LLR_out[NL] = (LLR_in[NL]*L);
                printf("t = %d ,NL = %d, LLR_in = %f,LLR_out = %f;\n",t,NL,LLR_in[NL],LLR_out[NL]);
				bit_hat[NL] = LLR_out[NL] < 0.0 ? 1 : 0;
			}
			for(CL = 0; CL < C_LDPC; CL++)
			{
				check = 0;
				for(NL = 0; NL < N_LDPC; NL++)
				{
					if(H[CL][NL] == 1)
					{
						check += bit_hat[NL];
					}
				}
				if(check % 2 == 1)
				{
					flag = 0; 
					break;
				}
			}
			if(flag == 1) break;
		}
		else
		{
			// VN update
			for(NL = 0; NL < N_LDPC; NL++)    
			{			
				for(CL = 0; CL < C_LDPC; CL++)
				{
					if(H[CL][NL] == 1)
					{
						log_I_V_C[NL][CL] = (int)(LLR_in[NL]*L);
						for(i = 0; i < C_LDPC; i++)
						{
							if(H[i][NL] == 1 && i != CL)
							{
								// log_I_V_C[NL][CL] += log_I_C_V[i][NL];
								for(l = L_offset; l < L; l++)
								{
									log_I_V_C[NL][CL] += log_I_C_V_sign[i][NL]*log_I_C_V_stream[i][NL][l];
								}
								
							}
						}
					
					if( NL == 0 )
					{
					    printf("vn2cn = %d\n",log_I_V_C[0][CL]);
					}
					}
				}
			}

			for(NL = 0; NL < N_LDPC; NL++)    
			{			
				for(CL = 0; CL < C_LDPC; CL++)
				{
					if(H[CL][NL] == 1)
					{
						for(l = L_offset; l < L; l++)
						{
							log_I_V_C_stream[NL][CL][l] = abs(log_I_V_C[NL][CL]) > rand_num[l] ? 1 : 0;
						}
						log_I_V_C_sign[NL][CL] = (log_I_V_C[NL][CL] >= 0 ? 1 : -1);
					}
				}
			}
			
			total_bit += (L - L_offset); 
			
			// CN update
			for(CL = 0; CL < C_LDPC; CL++)
			{
				for(NL = 0; NL < N_LDPC; NL++)
				{
					if(H[CL][NL] == 1)
					{
						// sign_value = 1;
						// min_value = inf;
						sign_value = 1;
						for(l = L_offset; l < L; l++)
						{
							min_value[l] = 1;
						}
						for(i = 0; i < N_LDPC; i++)
						{
							if(H[CL][i] == 1 && i != NL)
							{
								// min_value = min_value < abs(log_I_V_C[i][CL]) ? min_value : abs(log_I_V_C[i][CL]);
								// sign_value = (sign_value*log_I_V_C[i][CL]) > 0 ? 1 : -1;
								for(l = L_offset; l < L; l++)
								{
									min_value[l] = min_value[l] * log_I_V_C_stream[i][CL][l];
								}
								sign_value = sign_value*log_I_V_C_sign[i][CL];
							}
						}
						// log_I_C_V[CL][NL] = sign_value*min_value;
						for(l = L_offset; l < L; l++)
						{
							log_I_C_V_stream[CL][NL][l] = min_value[l];
						}
						log_I_C_V_sign[CL][NL] = sign_value;
					}
				}
			}
			
			
			
			// Early terminated
			flag = 1;
			IterNum_out[0] = t;
			total_bit_out[0] = total_bit;
			for(NL = 0; NL < N_LDPC; NL++)
			{
				LLR_out[NL] = (LLR_in[NL]*L);
				for(CL = 0; CL < C_LDPC; CL++)
				{
					if(H[CL][NL] == 1)
					{
						// LLR_out[NL] += log_I_C_V[CL][NL];
						for(l = L_offset; l < L; l++)
						{
							LLR_out[NL] += (log_I_C_V_sign[CL][NL]*log_I_C_V_stream[CL][NL][l]);
						}
						// printf("t = %d; NL = %d, CL = %d; LLR = %f; \n", t,NL,CL,LLR_out[NL]);
					}
					
				}
				bit_hat[NL] = LLR_out[NL] < 0.0 ? 1 : 0;
			}
			for(CL = 0; CL < C_LDPC; CL++)
			{
				check = 0;
				for(NL = 0; NL < N_LDPC; NL++)
				{
					if(H[CL][NL] == 1)
					{
						check += bit_hat[NL];
					}
				}
				if(check % 2 == 1)
				{
					flag = 0; 
					break;
				}
			}
			if(flag == 1) break;
		}
		
	}
}



// mex 接口函数
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{

	double *LLR_in; // input
	double *H; // input
	double *LLR_out; //  output
	double *IterNum; // output
	double *totalbit;
    
	LLR_in = (mxGetPr(prhs[0]));
    H = (mxGetPr(prhs[1]));

    plhs[0] = mxCreateDoubleMatrix(N_LDPC,1, mxREAL); // Output Size 672*6
    LLR_out = mxGetPr(plhs[0]);
	plhs[1] = mxCreateDoubleMatrix(1,1, mxREAL);
	IterNum = mxGetPr(plhs[1]);
	plhs[2] = mxCreateDoubleMatrix(1,1, mxREAL);
	totalbit = mxGetPr(plhs[2]);
    
    stochastic_offset_min_sum_LDPC_decoder_mex(LLR_in, H, LLR_out, IterNum, totalbit);
}
