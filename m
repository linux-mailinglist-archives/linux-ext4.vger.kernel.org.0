Return-Path: <linux-ext4+bounces-14232-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHMQN2a5omnZ5AQAu9opvQ
	(envelope-from <linux-ext4+bounces-14232-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Feb 2026 10:46:14 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD8B1C1CBA
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Feb 2026 10:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F172530880C6
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Feb 2026 09:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF5840F8DA;
	Sat, 28 Feb 2026 09:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdcpCQ1k"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE449407592
	for <linux-ext4@vger.kernel.org>; Sat, 28 Feb 2026 09:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772271910; cv=none; b=LFpLbLECSJTfR5sYlkMKN0q8kZeX+EHGdpp1vm2jwap/LADQbfA00qs5RV9ieSQjsetK0Fx5ku/ysF2U109J+dwqdfQoOgM5g8ZU+WU85QTQE1IJC1BppuDlRmQkoSGDsOaQ1SeNokDcQxBXsw5yDE+krkxayoOadvy//QbQR0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772271910; c=relaxed/simple;
	bh=JgQA6hF7V00oqmceoz3jXS3oNgydjZ5loRNyQ6eLhVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hOhyeG5mANGAXjbIl68lBp34bshAdNLrT9TqSAoIqHcjeFSxBMaksWUJ6WAvOnjANK1flPLlz5m1mqvw2tWcvWqLwDlfZXYn9i4JjWQ36YrDJQwpoN9eD4zY+uQPJD9iSo7JzgiCK4LNB+PLn4l6iukb3GjKsxGb6V5yOGhBBOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdcpCQ1k; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-43945763558so1984979f8f.3
        for <linux-ext4@vger.kernel.org>; Sat, 28 Feb 2026 01:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772271907; x=1772876707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e93FpEpTqD7Xqu0LewCf9chrUomQqmlqNIwnzg6ALeU=;
        b=AdcpCQ1kaK5jYq2keccwMa0F+pKDNE8W/7uUmQ2R7k/lLkMQI7iPnBYHTcmszkc92s
         achyHsbCICttp14pZ9CR/IsoH3lPeiSNE3tMyCO926M1Xd8JMnnMaWdiR3PhjWmb8T06
         cVYjDxN7ntaKIZNTA5LBSk9tqjBxqPsuyC9WuoNvEzJ/ND2A6mismKbQEO1FR6xDWbRH
         r5XrX14CAmv0f8WTjG3GspZxBi96KG5eIlJso0YgSLRXia3an/pV6MuQVkZCmKo6Q97k
         IWaj74cxtLrxjsARHGOafRzc2mex90PMR8lMHF4cox63FOiwymX+4EuLPsHewnmu6zge
         G5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772271907; x=1772876707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e93FpEpTqD7Xqu0LewCf9chrUomQqmlqNIwnzg6ALeU=;
        b=Ql5Hy4KeBBzSxE0FnBW0Mjl364omubEGSJTlO5LkHptd6YWwB+fZxuFf7scFZz8pb1
         nueae7lcbVUgctP9aK+1XpsTNjb07ROuVCgByGWUk/90tvz92M1I/7gNrKCfke1C4mcY
         skYo+QFFM2NiuyT5eJJBhbFfAB5fNzyrf1QVINA9+WQUu3H1H/k2yRV721M+f121TUU5
         2LC6KWKpcRNrjhMP3xfp5hruK+3w3qAWnO6KAc4NK4tY4htgd7NhWaYbPWhqN7tn/yGq
         LSijzilLtGvORvUN4dXzYJfxnIZSpAAdNN8QuFY3iAzpe3ILYwB9GcRRndrGEpZzqFj2
         a3Yw==
X-Forwarded-Encrypted: i=1; AJvYcCXVJ7YCCqHCRN7w0uCDBoNNaVO+5y+uQ652I6j/reHJx3WR9YxDfLcF3Jr4FcdliEHcuyPV1P3y0jxs@vger.kernel.org
X-Gm-Message-State: AOJu0YzEHyp6G3vZQ/Tnzm/VL4ifTm3A7pcEcNn9wYwlb0EG+6AOLuJx
	687jpjSFyfUFOWYKiGr0OkDCocB1WiOJhaUklvCl3gxFQQ43+OihgFwW
X-Gm-Gg: ATEYQzzyXllrvOHawxWGdYHNxLAp/YWKMtIWDLak1XVV6m4uJ+RxFpqCgqsxC62CTDN
	ZsaeFTk4zFFgtU1VTmaWcngkziwa2IZGOikLxquoo2WK1wKs6mBHpA/m+Vc1yp5pOdD6mURjFeO
	HsIVPQkZ/tMEnFUSwjBKK/n+n67uwCE7WSrZxN6lVPYM43uBbuKuW29Eter6khxiODp+3etVQhr
	3AvyWlHgCvXU9MhyhRapUFMpfEkQYYyy8KN3nv04J7zDIQTZM+LrTpOBeGm2B0PNKViNc8yPDf/
	XFeEG52PXO6w8sx/BRvG69gLTurTthW0yCGpfoKDOAIc1GS/zAmGL9aA2jwzdZluVwqxeJ2AeZM
	GFNOtm//EimrmL++5sFQlqlcBRg5OeTGzNhCMrEQ3IcHKB41REyKSFJvLyr47b/pk4+rIejiObM
	7ttfI/lyUqT29rdq78wOKrpf7+OFCz1pzpGryhq3TG2K7uw0NHNQ==
X-Received: by 2002:a05:6000:2388:b0:435:9690:f056 with SMTP id ffacd0b85a97d-4399de282edmr9551622f8f.35.1772271907005;
        Sat, 28 Feb 2026 01:45:07 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.215])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c763e78sm14173521f8f.26.2026.02.28.01.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 01:45:06 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: wangqing7171@gmail.com
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+512459401510e2a9a39f@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [ext4?] INFO: task hung in filename_rmdir
Date: Sat, 28 Feb 2026 17:44:57 +0800
Message-Id: <20260228094457.2253079-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260228082942.1853224-1-wangqing7171@gmail.com>
References: <20260228082942.1853224-1-wangqing7171@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-14232-lists,linux-ext4=lfdr.de];
	TO_DN_NONE(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangqing7171@gmail.com,linux-ext4@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-ext4,512459401510e2a9a39f];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 5DD8B1C1CBA
X-Rspamd-Action: no action

On Sat, 28 Feb 2026 at 16:29, Qing Wang <wangqing7171@gmail.com> wrote:
> #syz test
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 58f715f7657e..34a5d49b038b 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -5383,7 +5383,7 @@ int filename_rmdir(int dfd, struct filename *name)
>  	if (error)
>  		goto exit2;
>  
> -	dentry = start_dirop(path.dentry, &last, lookup_flags);
> +	dentry = __start_dirop(path.dentry, &last, lookup_flags, TASK_KILLABLE);
>  	error = PTR_ERR(dentry);
>  	if (IS_ERR(dentry))
>  		goto exit3;

Using interruptible locks [0] did not resolve the issue and it only improved
reliability.
 [0] __start_dirop(..., TASK_KILLABLE) -> down_write_killable_nested()

The root cause of this hung task may be a deadlock, and I've found a recent
patchset [1] that may be related. Further analysis of this patch would be
helpful.
 [1] ff7c4ea11a05 - VFS: add start_creating_killable() and start_removing_killable()
     4037d966f034 - VFS: introduce start_dirop() and end_dirop()
     5c8752729970 - VFS/nfsd/ovl: introduce start_renaming() and end_renaming()
     ac50950ca143 - VFS/ovl/smb: introduce start_renaming_dentry()
     833d2b3a072f - Add start_renaming_two_dentries()

--
Qing

