Return-Path: <linux-ext4+bounces-349-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7405780B21B
	for <lists+linux-ext4@lfdr.de>; Sat,  9 Dec 2023 06:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A36D1F21389
	for <lists+linux-ext4@lfdr.de>; Sat,  9 Dec 2023 05:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BE817D0;
	Sat,  9 Dec 2023 05:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PhQsXYTE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88ABB10E6
	for <linux-ext4@vger.kernel.org>; Fri,  8 Dec 2023 21:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702098391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zx2KXkKWGXskx9hgbxqcfFshAbEoRjOrA8XTrz3yxFs=;
	b=PhQsXYTExo5e8bVlPB5y+OKhmJtY2xKpiIRfjSCE9bycE3lN28XrYIzKGe7RvMNF1fqDTH
	1lE6SSRxX/zMVdazULE2irt8GPZURPza8XnWPwR4BqTB9jfDGy+F5vyztRPiNYhT57k+/Y
	JcnuXpLSHzhwOKfRfB+sjiWE1vvAexg=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-hRVv3vzAMa2jFluwxUJM4Q-1; Sat, 09 Dec 2023 00:06:29 -0500
X-MC-Unique: hRVv3vzAMa2jFluwxUJM4Q-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b8b07fbc1dso4164278b6e.0
        for <linux-ext4@vger.kernel.org>; Fri, 08 Dec 2023 21:06:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702098380; x=1702703180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zx2KXkKWGXskx9hgbxqcfFshAbEoRjOrA8XTrz3yxFs=;
        b=ZqOUyvd7rcA7PElcUz5p6mX8WojjUyr85m661RAEK6gNWlE1dnjNRwlOiiWq6R5q3b
         cUJHre4CcntMdkwHpCknCaslMCp9+H6ZWuUn0sujRYMpZh+hQrc2FQgaGsNHjR9L7vQx
         LrRrPlBIkHmrhR5mh9+3Fk4LmMKsb5PUZQiRLZYKd4Pw/Dn2qn0FUva1lEiQx1UOyWHd
         BbslB+CSzFVrAaBrhHDPDwKVV0c5io6M3g8U98tXmLUgoo1FAAJUBXUhYuv3MnXrxCOT
         VlcZmavtueATZEKAtb1lw/m0JhYKZOw9MtFaykquSBjKPCeXzS4yL2vsz0Jx5Xh0PbOt
         EOzA==
X-Gm-Message-State: AOJu0YwIMZ5fkb7mz0Vf9ZOrZ8n3YjOFFAqeuPfTWnK0s2poMC5nFF+5
	ovHyXK17Brvgw2xbzx3jPrV3SMPud944v4KmfKOilmkBOyEQ4uimNlRAkLrhto7Vw1xuiAtUiRN
	/pWf6bayfUiKsMtPFXTEOiQ==
X-Received: by 2002:a05:6808:38c4:b0:3b9:d586:f18f with SMTP id el4-20020a05680838c400b003b9d586f18fmr1730689oib.63.1702098380495;
        Fri, 08 Dec 2023 21:06:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECd3K0sY9EZGo2RH5DiJfxKjvWTvRoVlV8FXXIspjT93g5ldddKqeTGXRNnNamvgan+wi9og==
X-Received: by 2002:a05:6808:38c4:b0:3b9:d586:f18f with SMTP id el4-20020a05680838c400b003b9d586f18fmr1730681oib.63.1702098380226;
        Fri, 08 Dec 2023 21:06:20 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id r3-20020aa79883000000b006cbb65edcbfsm2522628pfl.12.2023.12.08.21.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 21:06:19 -0800 (PST)
Date: Sat, 9 Dec 2023 13:06:16 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	Jan Kara <jack@suse.cz>, Gao Xiang <hsiangkao@linux.alibaba.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: [PATCHv3 1/2] aio-dio-write-verify: Add sync and noverify option
Message-ID: <20231209050616.lcbfxdbqlgcskh3c@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <8379b5df9f70a1d75692e029a565199e98a535e8.1700478575.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8379b5df9f70a1d75692e029a565199e98a535e8.1700478575.git.ritesh.list@gmail.com>

On Mon, Nov 20, 2023 at 04:49:33PM +0530, Ritesh Harjani (IBM) wrote:
> This patch adds -S for O_SYNC and -N for noverify option to
> aio-dio-write-verify test. We will use this for integrity
> verification test for aio-dio.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---

This version is good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  src/aio-dio-regress/aio-dio-write-verify.c | 29 ++++++++++++++++------
>  1 file changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/src/aio-dio-regress/aio-dio-write-verify.c b/src/aio-dio-regress/aio-dio-write-verify.c
> index dabbfacd..a7ca8307 100644
> --- a/src/aio-dio-regress/aio-dio-write-verify.c
> +++ b/src/aio-dio-regress/aio-dio-write-verify.c
> @@ -34,13 +34,16 @@
>  
>  void usage(char *progname)
>  {
> -	fprintf(stderr, "usage: %s [-t truncsize ] <-a size=N,off=M [-a ...]>  filename\n"
> +	fprintf(stderr, "usage: %s [-t truncsize ] <-a size=N,off=M [-a ...]>  [-S] [-N] filename\n"
>  	        "\t-t truncsize: truncate the file to a special size before AIO wirte\n"
>  	        "\t-a: specify once AIO write size and startoff, this option can be specified many times, but less than 128\n"
>  	        "\t\tsize=N: AIO write size\n"
>  	        "\t\toff=M:  AIO write startoff\n"
> -	        "e.g: %s -t 4608 -a size=4096,off=512 -a size=4096,off=4608 filename\n",
> -	        progname, progname);
> +			"\t-S: uses O_SYNC flag for open. By default O_SYNC is not used\n"
> +			"\t-N: no_verify: means no write verification. By default noverify is false\n"
> +	        "e.g: %s -t 4608 -a size=4096,off=512 -a size=4096,off=4608 filename\n"
> +	        "e.g: %s -t 1048576 -a size=1048576 -S -N filename\n",
> +	        progname, progname, progname);
>  	exit(1);
>  }
>  
> @@ -292,8 +295,10 @@ int main(int argc, char *argv[])
>  	char *filename = NULL;
>  	int num_events = 0;
>  	off_t tsize = 0;
> +	int o_sync = 0;
> +	int no_verify = 0;
>  
> -	while ((c = getopt(argc, argv, "a:t:")) != -1) {
> +	while ((c = getopt(argc, argv, "a:t:SN")) != -1) {
>  		char *endp;
>  
>  		switch (c) {
> @@ -308,6 +313,12 @@ int main(int argc, char *argv[])
>  		case 't':
>  			tsize = strtoul(optarg, &endp, 0);
>  			break;
> +		case 'S':
> +			o_sync = O_SYNC;
> +			break;
> +		case 'N':
> +			no_verify = 1;
> +			break;
>  		default:
>  			usage(argv[0]);
>  		}
> @@ -324,7 +335,7 @@ int main(int argc, char *argv[])
>  	else
>  		usage(argv[0]);
>  
> -	fd = open(filename, O_DIRECT | O_CREAT | O_TRUNC | O_RDWR, 0600);
> +	fd = open(filename, O_DIRECT | O_CREAT | O_TRUNC | O_RDWR | o_sync, 0600);
>  	if (fd == -1) {
>  		perror("open");
>  		return 1;
> @@ -342,9 +353,11 @@ int main(int argc, char *argv[])
>  		return 1;
>  	}
>  
> -	if (io_verify(fd) != 0) {
> -		fprintf(stderr, "Data verification fails\n");
> -		return 1;
> +	if (no_verify == 0) {
> +		if (io_verify(fd) != 0) {
> +			fprintf(stderr, "Data verification fails\n");
> +			return 1;
> +		}
>  	}
>  
>  	close(fd);
> -- 
> 2.41.0
> 
> 


