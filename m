Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAC7BFFFF0
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Nov 2019 08:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfKRH7h (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Nov 2019 02:59:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25528 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726666AbfKRH7g (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 18 Nov 2019 02:59:36 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAI7vFTa013516
        for <linux-ext4@vger.kernel.org>; Mon, 18 Nov 2019 02:59:35 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2waygjshys-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Mon, 18 Nov 2019 02:59:35 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Mon, 18 Nov 2019 07:59:32 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 18 Nov 2019 07:59:29 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAI7xSoE39125068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Nov 2019 07:59:29 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DAC03A4067;
        Mon, 18 Nov 2019 07:59:28 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2C5BA4066;
        Mon, 18 Nov 2019 07:59:27 +0000 (GMT)
Received: from [9.199.158.191] (unknown [9.199.158.191])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 18 Nov 2019 07:59:27 +0000 (GMT)
Subject: Re: [PATCH] jbd2: Make jbd2_handle_buffer_credits() handle reserved
 handles
To:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
References: <20191115102210.29445-1-jack@suse.cz>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Mon, 18 Nov 2019 13:29:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191115102210.29445-1-jack@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19111807-0028-0000-0000-000003B9C9FA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111807-0029-0000-0000-0000247CE12B
Message-Id: <20191118075927.D2C5BA4066@b06wcsmtp001.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_01:2019-11-15,2019-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 bulkscore=0 phishscore=0 mlxlogscore=804 priorityscore=1501 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911180070
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 11/15/19 3:52 PM, Jan Kara wrote:
> The helper jbd2_handle_buffer_credits() doesn't correctly handle reserved
> handles which can lead to crashes. Fix it getting of journal pointer to
> work for reserved handles as well.
> 
> Fixes: a9a8344ee171 ("ext4, jbd2: Provide accessor function for handle credits")
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Jan Kara <jack@suse.cz>

Thanks Jan,
Yes, this also fixes the problem for me with dioread_nolock on ppc64 
machine.

You may add -

Tested-by: Ritesh Harjani <riteshh@linux.ibm.com>


> ---
>   include/linux/jbd2.h | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 3115eeb44039..a23a3528e07a 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1648,10 +1648,14 @@ static inline tid_t  jbd2_get_latest_transaction(journal_t *journal)
>   	return tid;
>   }
> 
> -
>   static inline int jbd2_handle_buffer_credits(handle_t *handle)
>   {
> -	journal_t *journal = handle->h_transaction->t_journal;
> +	journal_t *journal;
> +
> +	if (!handle->h_reserved)
> +		journal = handle->h_transaction->t_journal;
> +	else
> +		journal = handle->h_journal;
> 
>   	return handle->h_total_credits -
>   		DIV_ROUND_UP(handle->h_revoke_credits_requested,
> 

