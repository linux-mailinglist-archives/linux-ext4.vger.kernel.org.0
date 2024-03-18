Return-Path: <linux-ext4+bounces-1677-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA4B87E655
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Mar 2024 10:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28CA428245A
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Mar 2024 09:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE882C6BD;
	Mon, 18 Mar 2024 09:50:39 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A082CCD5
	for <linux-ext4@vger.kernel.org>; Mon, 18 Mar 2024 09:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710755438; cv=none; b=SZv6q+aG5rNkyeacqCXn3yScbBCF5FjzxU1wKkPD36971XwgkI6Lfp1VMwsv1kDR0vZWEeJsmpxkUUJVYnPAvdtjfazrZsFcqlEDlX7t/a8xNAQd+qPAR82ep+fyOixNr77tISz/tCRZfmqvUorLyNIiHJISHRBSQBFcpkwAbaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710755438; c=relaxed/simple;
	bh=SMfcuLh0dRpDs59PZheUo795qCve0pdqPff687xm1co=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WShWcjztYt4UA4GbGxWLi2UgO0AEcKhTlUMZ702Fa37gx6hBl3JElzl5pdbh/oMjkSwDoz0FwwDV49LSdw/Td50hIBbHJvOzQ4cZZ9/U8s9pOLLSopt4U3aTkMrZZxVeJDVOv1Kak6LFmQ+hUw7KRbIg5s2hwUS6eL8wn8/7cas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TyqLg1jK3z2Bgfx;
	Mon, 18 Mar 2024 17:29:31 +0800 (CST)
Received: from kwepemm600012.china.huawei.com (unknown [7.193.23.74])
	by mail.maildlp.com (Postfix) with ESMTPS id D0D8B140153;
	Mon, 18 Mar 2024 17:32:02 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 17:32:02 +0800
Message-ID: <1f7db2f7-5b56-4235-85fc-a767cd4c6b59@huawei.com>
Date: Mon, 18 Mar 2024 17:32:01 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] e2fsprogs: debugfs: Fix infinite loop when dump
 log
To: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
	<linux-ext4@vger.kernel.org>
CC: <louhongxiang@huawei.com>
References: <20240226081451.3224276-1-haowenchao2@huawei.com>
Content-Language: en-US
From: Wenchao Hao <haowenchao2@huawei.com>
In-Reply-To: <20240226081451.3224276-1-haowenchao2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600012.china.huawei.com (7.193.23.74)

On 2024/2/26 16:14, Wenchao Hao wrote:
> There are 2 scenarios which would trigger infinite loop:
> 
> 1. None log is recorded, then dumplog with "-n", for example:
>     debugfs -R "logdump -O -n 10" /dev/xxx
>     while /dev/xxx has no valid log recorded.
> 2. The log area is full and cycle write is triggered, then dumplog with
>     debugfs -R "logdump -aOS" /dev/xxx
> 
> This patch add a new flag "reverse_flag" to mark if logdump has reached
> to tail of logarea, it is default false, and set in macro WRAP().
> 
> If reverse_flag is true, and we comes to first_transaction_blocknr
> again, just break the logdump loop.
> 

Hi,

This issue is easy to recurrent and the patch has been tested ok
to fix it, so friendly ping...

> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
> ---
>   debugfs/logdump.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/debugfs/logdump.c b/debugfs/logdump.c
> index b600228e..05ea839a 100644
> --- a/debugfs/logdump.c
> +++ b/debugfs/logdump.c
> @@ -52,6 +52,7 @@ static int64_t		dump_counts;
>   static blk64_t		block_to_dump, bitmap_to_dump, inode_block_to_dump;
>   static unsigned int	group_to_dump, inode_offset_to_dump;
>   static ext2_ino_t	inode_to_dump;
> +static bool		reverse_flag;
>   
>   struct journal_source
>   {
> @@ -80,8 +81,10 @@ static void dump_fc_block(FILE *out_file, char *buf, int blocksize,
>   static void do_hexdump (FILE *, char *, int);
>   
>   #define WRAP(jsb, blocknr, maxlen)					\
> -	if (blocknr >= (maxlen))					\
> -	    blocknr -= (maxlen - be32_to_cpu((jsb)->s_first));
> +	if (blocknr >= (maxlen)) {					\
> +		blocknr -= (maxlen - be32_to_cpu((jsb)->s_first));	\
> +		reverse_flag = true;					\
> +	}
>   
>   void do_logdump(int argc, char **argv, int sci_idx EXT2FS_ATTR((unused)),
>   		    void *infop EXT2FS_ATTR((unused)))
> @@ -115,6 +118,7 @@ void do_logdump(int argc, char **argv, int sci_idx EXT2FS_ATTR((unused)),
>   	inode_block_to_dump = ANY_BLOCK;
>   	inode_to_dump = -1;
>   	dump_counts = -1;
> +	reverse_flag = false;
>   
>   	reset_getopt();
>   	while ((c = getopt (argc, argv, "ab:ci:f:OsSn:")) != EOF) {
> @@ -477,8 +481,7 @@ static void dump_journal(char *cmdname, FILE *out_file,
>   		if (dump_old && (dump_counts != -1) && (cur_counts >= dump_counts))
>   			break;
>   
> -		if ((blocknr == first_transaction_blocknr) &&
> -		    (cur_counts != 0) && dump_old && (dump_counts != -1)) {
> +		if ((blocknr == first_transaction_blocknr) && dump_old && reverse_flag) {
>   			fprintf(out_file, "Dump all %lld journal records.\n",
>   				(long long) cur_counts);
>   			break;


