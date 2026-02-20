Return-Path: <linux-ext4+bounces-13755-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UslmE0EhmGldBAMAu9opvQ
	(envelope-from <linux-ext4+bounces-13755-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Feb 2026 09:54:25 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E35165F17
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Feb 2026 09:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5A063023372
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Feb 2026 08:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CB33112B7;
	Fri, 20 Feb 2026 08:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtU/prZI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29902310784
	for <linux-ext4@vger.kernel.org>; Fri, 20 Feb 2026 08:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771577661; cv=none; b=MxBS6g5oGNE9tCxRKpodWOMZ80yHvWDnpUGWeNxlVMnwWGQhO1STsnDz2tYeLCg27AkwjqYHlqtutoHXyD1tbOfr89Hy/HwjAipll+X3WkFCc+2kWct0nrCJkpq5gnOk1CoMqkkmjpUTUDlc4Caz2Mp2pA2Cyua4+jNsdRspU2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771577661; c=relaxed/simple;
	bh=iHCOMCQMPTUhq+8l+2pB++BXd/nGu+pU/9ctEEt2wRQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=JqqvJ0Yvd/kSJ6yIExJvyK5tX1p8Otc8ydbl5qLc8Hh+o9GkjXYnQw16JsCsVOqxHXoXKkJF5mLKAp9a39iv7haDisHq/o1DeC2AAptbCxfE6WfaHaxvakwz7YRjlnXKSaWq+0RF7M9yJ8xF2hO4FqQgFr8moNbi6lfkdOGLfPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtU/prZI; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-824484dba4dso1511185b3a.0
        for <linux-ext4@vger.kernel.org>; Fri, 20 Feb 2026 00:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771577659; x=1772182459; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SH5A5MWgTbSDvXHaIrM5Im/+6NpKCF5JKyje6E+6QeA=;
        b=OtU/prZIl1J9m/4trWfzkc8Pnj1fsqr6tmECUZPIEyyI3J1ZKvke4dMErVA+Ts8uEY
         ZJD4/9H3BJ7ziN7M/PmN1ovte20Ji1tJx8YFIenWzZDFGGZR07v2OZKW7dNCu245nxlH
         Q3d5J0CGYel1OI4FPayfzMoR/L/QkY+F+aSBedvf3OFsyjxP83KonaqygF0MNydLrSCc
         IOBZ67apvh3VgKlkiGRm+edh5vFMUcUus6G4qN3w6mSZuFCpNWt6TTn7bMAJp13c4mR3
         0mGl+T8EY3ATSnKgR0sCLF9snY0qP6saSAJALqrIbA91Akcpe5+UKNgH4L6AHBhiMNvS
         Y+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771577659; x=1772182459;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SH5A5MWgTbSDvXHaIrM5Im/+6NpKCF5JKyje6E+6QeA=;
        b=vWMNrJp4w7Ixw000ew88OUzEGlRFvxv32K/AkdN26H03Posb7iOR0nUKhTZGUWJ5Sg
         Djfy75Cd9f2S7GRo7SJRS65mVx3mCipyWCCSM0BZgRNThCpRfmwwECuVNlb/zrZh5Ybm
         enH/rIBA0n+sDd9wEZKlgiG+lY0VvC6/Rgx3vtzSq3dc/oirm+g6jwBxiuZvbYBExOQZ
         LhxrPhTW0lUi6vgg3YBZlYGyFIo5ATS7uSWifaW6J2ByamTrNvMHW6eB5CDtxl98TTWL
         WYr2/8Y1VijHoZa1tpk67Zfw8Ky2ApmxEeByhdAHWv8EIteimSqQ7V0XprBvfRQjvGj+
         AYQA==
X-Forwarded-Encrypted: i=1; AJvYcCUP+xMGflfeogt3qaxEGI7h4y/crAalNHY1pLSsctZYrGB4KStMiJ22cLHugSdpZsVVrgPtkmfSC3X2@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0dwk0JyiT4cQCLr/m4SFFpay/vwZo8OQv+2anhF/xy6VfV6SW
	PvS5hSrShh2TPpaG1QEbmEwqoJZZS551JQwCn6xFbepWWjSsCXBNkp1a
X-Gm-Gg: AZuq6aK6z0JuNsej3iE68mbq3MJe4Rxe9fU6qEYQBdbEeLQjIjfsmXCKSooxnxt+Jlg
	vw4HmL/h32QHNEjA8shEkg0hq/zJA7O7AHOj7YdGW5TTKYiinNRt5Xw5vSk458IipurWJbTTf3J
	D7gjqDgLiSemxLh9bUf6e54KA8m/cbuqHfNzGW77l54YqqtFPApcLLyyR0MsDigk1oSTnERxMZj
	PkT4yB+tDtG/FnBoN9T8PWCu4tvbSdlyc5IiIq4tTbju5rKEmEMWzgu18bilA7L9STtM6SEuu+u
	IrmCTVsc0t2K4ckmCfqjbpaiCbasBTRcfRrlSsSjJ5AZloti/j7jTg/g937hVYwZqeUR9NhcBHw
	JfhNpqKogettjhFDlu+0zG5623Ls7dxHn/f7UimKYWBVKmkdTiN+Ks9/Pccoop7VCjXlGgQ6I4o
	kE0Apk0k04o1qIMmLT
X-Received: by 2002:a05:6a00:1d14:b0:81e:ce07:7f3d with SMTP id d2e1a72fcca58-8252751d47dmr6752935b3a.31.1771577659482;
        Fri, 20 Feb 2026 00:54:19 -0800 (PST)
Received: from dw-tp ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6a2c6b1sm21962400b3a.10.2026.02.20.00.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 00:54:18 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Theodore Ts'o <tytso@mit.edu>, Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH RFC] Update MAINTAINERS file to add reviewers for ext4
In-Reply-To: <20260219152450.66769-1-tytso@mit.edu>
Date: Fri, 20 Feb 2026 14:22:20 +0530
Message-ID: <87ldgn3igr.ritesh.list@gmail.com>
References: <20260219152450.66769-1-tytso@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-13755-lists,linux-ext4=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riteshlist@gmail.com,linux-ext4@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-ext4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,dilger.ca:email,suse.cz:email]
X-Rspamd-Queue-Id: 85E35165F17
X-Rspamd-Action: no action

"Theodore Ts'o" <tytso@mit.edu> writes:

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
> +R:	Jan Kara <jack@suse.cz>
> +R:	Ojaswin Mujoo <ojaswin@linux.ibm.com>
> +R:	Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Thanks Ted, for your support!

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

> +R:	Zhang Yi <yi.zhang@huawei.com>
>  L:	linux-ext4@vger.kernel.org
>  S:	Maintained
>  W:	http://ext4.wiki.kernel.org
> -- 
> 2.51.0

