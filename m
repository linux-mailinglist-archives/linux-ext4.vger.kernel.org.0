Return-Path: <linux-ext4+bounces-13756-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMU9BNRmmGmJHgMAu9opvQ
	(envelope-from <linux-ext4+bounces-13756-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Feb 2026 14:51:16 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4DF1680B8
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Feb 2026 14:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64C4730490DD
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Feb 2026 13:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18E9348860;
	Fri, 20 Feb 2026 13:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y55Rmg9V"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4160E342CBA
	for <linux-ext4@vger.kernel.org>; Fri, 20 Feb 2026 13:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771595314; cv=none; b=KjAKW/5JJfiYvWaOx1qd5hg3T89DpDHdvYdpS2jkThEfpixlxxHmXyTa2BGgGs8OcevaLIEgrDFRiuOm2tZJVfhUF+kbflAc2/MTlOhx67O4RlDesun93+pr/1q5u17UdF/bcz8YUitjrashp3OREoYFKzsR04vdudM/9kD2X2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771595314; c=relaxed/simple;
	bh=iLMqCVMT6bo/C0fs16w6mEPr8PD4+VGxBd4CweEJtqE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=qBPMVud8/UiHqUk69WrzzjfLYlcpbvch7+bRioU7ZZtI9qzpTS9V3jxqd2kGTN+caWkQy5la7okhpqNaKxgwGUU6G27MJYmj+sgZ8pdZXxtsPf6VfrBN4KlHE2PEw0+kd+xJyBxjyOheUt2oeUcxIVof4kEMORb7OOAdxG9F5bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y55Rmg9V; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-824c9da9928so1106933b3a.3
        for <linux-ext4@vger.kernel.org>; Fri, 20 Feb 2026 05:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771595312; x=1772200112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+h0F0ecHeBI1ZS0iJ+if8RGuk25A/Z24xulmYkiBMBc=;
        b=Y55Rmg9V/Sv7tvI+YNIFQeLHlt4X6lGtsQutCKx1bwOXy6kmbEO0wFOUteCeCNAQFM
         tqSMWORzF/Jt2E2AfsHKBXNywhCTEa28QLOHfn4z6bmAw6R8JpkdbrEX+Abkw5OAv9Jw
         xN3Z2MldviGLtbdST14xLQzghefkcx7mNTJsFjgcpeYWW/5IX4aISEJk8iDlUTWhXrS+
         oPLT1rhbz/5zOO/8jIvptFLryYezz4Q4MTbEG0y6invF8AFqbwWo3GJoSlCGuhi7bPsc
         4y0u84TnrLxnqa4sT0NHMYP6eqUvZZH43IY33LYpyNRWoLdClQ4ZBEzoNbpLdBR4AVKb
         z/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771595312; x=1772200112;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+h0F0ecHeBI1ZS0iJ+if8RGuk25A/Z24xulmYkiBMBc=;
        b=JhZmc7on53J45bZaU9Yvy22QD69onPtHS751AzkrBEmF2OyYqYi753S7rHEj/28Dcs
         fE4H5KHQE4IlDCG1v4HxWx/0OSMFTTd5AQH8PTpwm1MdSSt/ChmNkToLOhjBUxn2bqhG
         lBuCNpkvuKJDtm5upK/M8bi+v67rZek24cdlPmQiRmBQzMiEztrEEUWZ2oPfNxdyFVN2
         s4EME9t27e3mRTZRV368fCIPLDCL7yT6DpvQmWCl7SvJNb5K1hvkkZiO0Zfl4MfiwhFz
         w+Ca8FaLFpqi+LfYj6DpfnGk2/WrzckeW5GhcwCQXiX2Kx8jvWhxQ4b0VhD/l0EqdzbX
         KD8A==
X-Gm-Message-State: AOJu0YzKg1egv3kokr16wjQh87Ejw4IjFmTlOxTxkj3Dzn5WTIUqSRoX
	7WUoI3RaDTj8j5n+HwXu/YP6Q5v9hPHS4ST29i1XobGhCsNtZvhHXbQ+
X-Gm-Gg: AZuq6aLo6Qq8fF/YQfHYUy00UF16zR6ZUxf21wtfFBp3RYOP5Zm0mGOX2ImNw378v2t
	5LoUSmexW5iGNi3wfQJN9bW7XqgAC6xv3r476jiXuOGHn3gxjRKKyMbDMSMo8u7ZLDg4W5gDC/1
	qL4JXbVwf31Sc0CUy+CEWydofMyll4NRHe8jYcMWH/SV9eLxNyoNSOog0l0g5BsOz+8lI6sD9pc
	wfnjcG3uK1Rz2HIFbONBCC9XiKa8RN66ReF8eA0bqxplg8NINgeQB8PM5c/AlYARzyR/Te4u5ww
	j7nZMOj89DCb1i4rj6almRrcTPPPatYf7cjonKUQlFPa410aNmhW6GqtdvFhBuyww7FLt387Ycs
	DPZ7iB3knA0rqFR9XZBsxqSNmGfrNotBrpQN9bL1ZF8bRBfVd7tu4VU4GMWYsprzAN6QljIRPBY
	Xs6ThFzYdcBsyv+eBK0F2FyAk/4xiqoK/pK7isO046HtVSkHlPHCMzyPpnSI5QEJpZFR1pDGDgF
	JfODBnhybzo1Q==
X-Received: by 2002:a05:6a00:4188:b0:81f:3f6e:166 with SMTP id d2e1a72fcca58-826b68ba0eemr6539226b3a.46.1771595312547;
        Fri, 20 Feb 2026 05:48:32 -0800 (PST)
Received: from [10.233.167.7] (public-nat-01.vpngate.v4.open.ad.jp. [219.100.37.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6a431f2sm24729053b3a.22.2026.02.20.05.48.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Feb 2026 05:48:32 -0800 (PST)
Message-ID: <e3edfb61-e9f3-4b74-b0d5-9672ccacf0ee@gmail.com>
Date: Fri, 20 Feb 2026 21:48:26 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, libaokun@linux.alibaba.com,
 libaokun9@gmail.com
References: <20260219152450.66769-1-tytso@mit.edu>
Subject: Re: [PATCH RFC] Update MAINTAINERS file to add reviewers for ext4
Content-Language: en-US
From: Baokun Li <libaokun9@gmail.com>
In-Reply-To: <20260219152450.66769-1-tytso@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.alibaba.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13756-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[libaokun9@gmail.com,linux-ext4@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,alibaba.com:email,suse.cz:email]
X-Rspamd-Queue-Id: 2A4DF1680B8
X-Rspamd-Action: no action

> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  MAINTAINERS | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index eaf55e463bb4..481dceb6c122 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9581,7 +9581,12 @@ F:	include/linux/ext2*
>  
>  EXT4 FILE SYSTEM
>  M:	"Theodore Ts'o" <tytso@mit.edu>
> -M:	Andreas Dilger <adilger.kernel@dilger.ca>
> +R:	Andreas Dilger <adilger.kernel@dilger.ca>
> +R:	Baokun Li <libaokun1@huawei.com>

Hi Theodore,

Thank you very much for adding me as a reviewer for ext4.
I am honored to take on this role and look forward to contributing
more to the community.

I just realized that my old email <libaokun1@huawei.com> was used
in the patch, but I've actually stopped using that one. I should have
updated the community sooner—sorry about that!

Could you please use this current address <libaokun@linux.alibaba.com>
instead? I want to make sure I don't miss any future discussions.

Thanks again for the trust!

Regards,
Baokun

> +R:	Jan Kara <jack@suse.cz>
> +R:	Ojaswin Mujoo <ojaswin@linux.ibm.com>
> +R:	Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> +R:	Zhang Yi <yi.zhang@huawei.com>
>  L:	linux-ext4@vger.kernel.org
>  S:	Maintained
>  W:	http://ext4.wiki.kernel.org
> -- 
> 2.51.0
> 

