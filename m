Return-Path: <linux-ext4+bounces-13757-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8SMKAHsNmWm/PQMAu9opvQ
	(envelope-from <linux-ext4+bounces-13757-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Feb 2026 02:42:19 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1E016BC55
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Feb 2026 02:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 567C63002B67
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Feb 2026 01:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE8A31B824;
	Sat, 21 Feb 2026 01:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="Qa+fGak6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE40327732
	for <linux-ext4@vger.kernel.org>; Sat, 21 Feb 2026 01:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771638133; cv=none; b=tHK4Px/dwTtLHndsPUaktLt8ni/sdtzaqdUsh1nI+Pu6PnlY82zMnfOqjZVrvdHgh4nzRCj6kUL1OGdcMIXdXcJDdk5ScO4rdrGFyaLLVwnKdimZ9irlevU+CK4svtJ+KIKT/PMeTOi8plJm4xJNNAj8jTrHKmnQBLJmgap2DBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771638133; c=relaxed/simple;
	bh=AvHJv/Q6cD3l262faU4tivLGwpllBQqAQCB+reNXqy0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=EDLRzYukocNO8JsNTp8Pb0S4E/sGnzI0whFIUnWng1p3wWH/+o14FU7h4fAGlXSUZ4KTshHdUkOdyV1dRMaenVF8j2NzOVHTw5ep4xZ9Flb7hZFiZcLUpa5ioZ2RdiccuKiCLFH5bW1TeHLhVVl89G94pC2vC4U+Na6wQLXJ0HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=Qa+fGak6; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a871c8b171so16307295ad.3
        for <linux-ext4@vger.kernel.org>; Fri, 20 Feb 2026 17:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1771638131; x=1772242931; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eo9mkkg7kiePtU+Yqi/hxW+TGZCvz+sgVunJ7eAlv50=;
        b=Qa+fGak6y+S/8Srl0IwQoQ19ukHoorYcKaX6JGiDMSRP6pxgXQbGbxS6W8AE4zCdoZ
         5Rqbjkslo4gUgGfJn7z6xJIwcMiyTpU0dLunJfn47VkENU4Z0WjVHcMRGnqoMyGnSAfz
         CWnOstVAk8TjGc8Tw/D+ggUBne63SP7JgGRBhrwfW2jLX9y/2r4C6nS6UbLvBZ3J5pJi
         Mbp6IOKEgrERpB07D9wxIzNCp80dclm9C9Lbl8r4Oxe0+3fj/dkcmFLPYrtdm2pAzPhy
         8wLVlbPyEMN/TqDqsOlvKtGI6ZycqqHsv/ARP5XKuBKbd5ByfEB8yqeE+kjN9JAoSnCD
         PhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771638131; x=1772242931;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eo9mkkg7kiePtU+Yqi/hxW+TGZCvz+sgVunJ7eAlv50=;
        b=O+jfV20B32sq5kxtUpuHBt3B8RwVCRtt/8OA6VPIhU/i8RFv8LWp7D4C4aac4kcvRS
         /n8WDHDZ3P1vIJYVQwsiOCFMcSRqXYfWAOuI4iYLF2/NrKTnX43oWfdOicskgJj2rqCP
         6UCdtmVRK8eFLnp4/XZkHtDsxae/lSBymbAA+aDb6V4MwbMsOEnQGNr8nT4l/Ua3kDkV
         pb4WtXD14Stvd6IUwXYCQ+rZowP7Q0uGZBlWVGCb6nPouyRoJQeVdX/rJYGj/6edYhof
         O91GSDYUQT80/ZCIeUcRF0BkgRo5VBfnYnaJQE8Cu2xfyrvbtqVAIV7Lt1wsI/wLPDiP
         Mjjw==
X-Gm-Message-State: AOJu0YycnBGKhuUw5MvKd5I1YkUIGntwHrPnk1BNuejN44Wv7BjOO2qS
	mjA93omg487CeMmTloCV9W4+QzIJzKLjv/P+F+trvtn1I2jPTozDzgXmK0kA9cSEeeFCPxXrXRp
	e+WTG8sM=
X-Gm-Gg: AZuq6aLR0s8H9upvZuozTcv2yE1zx4x4jb2GZYcEkRx6QH/9EA4f6uVQIeoE8avBSkB
	wSuINUEJlrezN7bhrLnusFboIxAWLKADiltlDhdpbin6UvVkALrCoPXayZf2GRpXkoRYAyjrE9l
	vmlfHx5+n1NmiDqo29c6szscYYKHfdU2RahndgoUh/fo1K7eFu46AYQ+6w5/3O6QufZMUlMTTf6
	fkTM6d2P76Ci2+avj56+BK2WANDDukSGGwrrHInlSX+Z/hXFQRQcFiIoVD8UJLgUjpQPGMfPF6e
	dFshXoTuzdVx63oeQJLqSMwMwWwUYA3q69bYKeHbdgArjSRQorG95BNvVTBKM4B9bjmZrKTKj5U
	yBmASZaQCyzTvjPe6DuXdzLhqtNpr7kVFPeigCTagMbJhsDtQuFIfeUtWT1PC1yHy+Ml7KZ9tE6
	oIcnGQ9JLebYOQgeLXcUAxFq3OaLUSmlC5UeRZaP/SOMY5eYVcyLjSchhTcL0N15bHSHxyZ8h3I
	rc/dg==
X-Received: by 2002:a17:903:1a2d:b0:2aa:e817:1bd3 with SMTP id d9443c01a7336-2ad744e1731mr15102485ad.29.1771638130913;
        Fri, 20 Feb 2026 17:42:10 -0800 (PST)
Received: from smtpclient.apple (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74f5dc87sm6181775ad.22.2026.02.20.17.42.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Feb 2026 17:42:10 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH RFC] Update MAINTAINERS file to add reviewers for ext4
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <aZgHUY7L4DgWmsa6@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Date: Fri, 20 Feb 2026 18:41:59 -0700
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <217AF824-5C28-4B94-9FBE-EEFF6B3CA3D9@dilger.ca>
References: <20260219152450.66769-1-tytso@mit.edu>
 <aZgHUY7L4DgWmsa6@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
To: Theodore Ts'o <tytso@mit.edu>
X-Mailer: Apple Mail (2.3864.100.1.1.5)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[dilger-ca.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-13757-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[dilger-ca.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dilger.ca];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adilger@dilger.ca,linux-ext4@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Rspamd-Queue-Id: 1A1E016BC55
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 10:24:50AM -0500, Theodore Ts'o wrote:
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
> MAINTAINERS | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index eaf55e463bb4..481dceb6c122 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9581,7 +9581,12 @@ F: include/linux/ext2*
> 
> EXT4 FILE SYSTEM
>  M: "Theodore Ts'o" <tytso@mit.edu>
> -M: Andreas Dilger <adilger.kernel@dilger.ca>
> +R: Andreas Dilger <adilger.kernel@dilger.ca>
> +R: Baokun Li <libaokun1@huawei.com>
> +R: Jan Kara <jack@suse.cz>
> +R: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> +R: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> +R: Zhang Yi <yi.zhang@huawei.com>
>  L: linux-ext4@vger.kernel.org
>  S: Maintained
>  W: http://ext4.wiki.kernel.org

Yeah, I haven't been keeping involved in ext4 development as much as I
should be, so this is fair.

We're going to take another crack at submitting some of the Lustre ldiskfs
patches into ext4 in the next few months (dirdata that works with fscrypt
and casecomp, the "-o fstrim" mount option with persistent trim state,
and hopefully others).

Cheers, Andreas


