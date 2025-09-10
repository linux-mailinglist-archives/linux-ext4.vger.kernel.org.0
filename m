Return-Path: <linux-ext4+bounces-9899-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9A6B5184F
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Sep 2025 15:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825991BC1417
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Sep 2025 13:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B2F21ABD7;
	Wed, 10 Sep 2025 13:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t70fjN2C"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B861E21507F
	for <linux-ext4@vger.kernel.org>; Wed, 10 Sep 2025 13:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757512322; cv=none; b=lUpxkssA07Osl5l/YaSeIny4YxZd7bYMMj7Q0utsn1NbwFVqq/Un9jjjeKmhNl5wjWKRXPpRhSR+kccT6d4PFwDDM2gyseT0v3XUIvPfXfVIMmMu3nCExoeyaC0bB8qTToX5Jc9F/FV/TlsZoDCbtGsRSqfB/KUWRBaeg1Dfo/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757512322; c=relaxed/simple;
	bh=Ft8jyat+7hNdlt8cJ47WHsOzKv9fYpU6FX43VjbG/y8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KYqz2JTA6oIlxGLN9Tk8rEyQdPkOTmz1IOHk4T9+XhJRbXhap/gsb0WHG1MWgb6UE+vlGQKFFPum0+vCzgL8rtF7rjqrVBOHrmuk7POUaDAdRfbNGEpBPsZOeqOT3MN4BUzBCgE0fBzK4oKV/8IQBO+cdIMV/P6RuK8TNs+Ax4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t70fjN2C; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-7211b09f639so74172276d6.3
        for <linux-ext4@vger.kernel.org>; Wed, 10 Sep 2025 06:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757512320; x=1758117120; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/uzfT2SZbtSVFwjLgauSyAYiAWQx/GJPtfk/UINh1Gc=;
        b=t70fjN2CTIPOnipIOfxWhS7y74u7iZC91zlHQG5bOSYVNq2nKFvyonfs9EnKKOqDoj
         oQGAtBzCuhKKgXlyLxM2qhl4S83hAEdttuvKyRlxE+m3sDxc+JA4x4T9eMexH5ZDAoR4
         17lXbcV+jMmI2KgOeMAyWrzPRj/Bpdc9hmQIE3UxsW5BVW0HwKj9OWmtRq0XFSEY1/yN
         bZgC6r7/26uYsuWFyovq5pC30DoeW8y9DFmp79GyuPYeDCB/Cu44rbQxHBVdpbHfEZPU
         R/c/lKnIRqLO0J0F5yhtoEr/7ncXtI/987CBQSyjzHizh+soIVyit8IBBYDpBTX8JxGw
         IbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757512320; x=1758117120;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/uzfT2SZbtSVFwjLgauSyAYiAWQx/GJPtfk/UINh1Gc=;
        b=FAzd3cPVfmQhq6pl0B9y3zToeazr95UI7n4exAucEujYdI/ErNoLR11g1L7XmGnyOM
         VqWJaF/j3srXu8KIX6cP0RKfAiyVczEWApn+tLCua8KWC9jaWa7bs1KR/bpIfSBhfP+e
         ad7t31e+0JAC2YnfgXy6hd8x+4gCV3wPJpK96fu9H9LPfXpHdXIMfGUwgXQ3R9rz9DIT
         /XgnhEtwuJo0j2/c8SN9yyKB6DjpDQtqWm9Bjpf/XBkcmhqDHcDubDDkqeY9LURCHabj
         4h0nXEsS4Bm7bL/kOJ85pRe48okQMdZL6sRFv91zYP9yzQga8H0/gvIT+wJw8lO/vmvb
         4vIw==
X-Gm-Message-State: AOJu0Yw99MjiARlRkJplpbFagzK/OUh2zBQ1MHCWuRd0RwbOYOs3a/UO
	WZuLe7orP2hqRRpNMsVlDFJy5niJh06unlhSkoCDK8WZDcTg8m2vTmKaISBnCoAWbuyc6leDt5D
	owf6D
X-Gm-Gg: ASbGnctoXb1ncbK0MDBrlN4IDo5RcYrE+ApKHINTpMEMdYFr3VpZXGDX1SbO/R9Gx4c
	moaTNgjFg2Cy+C6nmhf5msp0TuzKjH4APHivvIzu5nElUr707/8PF2D+LVu2OAN/W5Ym8opn259
	/DjKAtj/OguIvhZWNvTc/f+wgN7OImXmaCvo/pfnPPtSm19c2bvilh04p1b7Udnft6l/HmoVL2J
	Sda+UmAo8KkdXxcGWLBIUFBA8zw7hlox7hIxb8hLbycX1brunLVWpKhLm4dkFalg0cFAXJgLSWF
	MNbUcW0In5hoj7g4+6j+Ksc/FjdOOk2Ze+7HSBrOYOLYhzznKqBiubZIHKh+ehOWB14qB53M7my
	ub1y/rt7pbALvvZ4iFLnbv31zE37FMSlizM5Lr4J//Yw3Mh4yiyrIcGVFHc0=
X-Google-Smtp-Source: AGHT+IGlI3JkWZ6QetFAfQ7+0o0XBZjCIH3vOA/mXPny5ySk2U0YyPQCsKAg1fBJwtkO8bAfAxeHyQ==
X-Received: by 2002:a05:6214:2387:b0:70d:81ce:ec1f with SMTP id 6a1803df08f44-7391f9b36a5mr177026206d6.12.1757512319403;
        Wed, 10 Sep 2025 06:51:59 -0700 (PDT)
Received: from maple.netwinder.org ([184.147.192.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7252d6ad05asm137500176d6.62.2025.09.10.06.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 06:51:58 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Wed, 10 Sep 2025 09:51:46 -0400
Subject: [PATCH v2 2/4] mke2fs: support multiple '-E' options
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-mke2fs-small-fixes-v2-2-55c9842494e0@linaro.org>
References: <20250910-mke2fs-small-fixes-v2-0-55c9842494e0@linaro.org>
In-Reply-To: <20250910-mke2fs-small-fixes-v2-0-55c9842494e0@linaro.org>
To: linux-ext4@vger.kernel.org
Cc: Ralph Siemsen <ralph.siemsen@linaro.org>
X-Mailer: b4 0.15-dev-56183

The '-E' option for specifying extended attributes can now be used
multiple times. The existing support for multiple attributes encoded
as comma-separated string is maintained for each '-E' option.

Prior to this change, if multiple '-E' options were specified, then
only the last one was used. Earlier ones were silently ignored.

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
 misc/mke2fs.8.in |  4 +++-
 misc/mke2fs.c    | 16 ++++++++++++----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/misc/mke2fs.8.in b/misc/mke2fs.8.in
index 14bae326..99ecc64b 100644
--- a/misc/mke2fs.8.in
+++ b/misc/mke2fs.8.in
@@ -268,7 +268,9 @@ Cause a kernel panic.
 .TP
 .BI \-E " extended-options"
 Set extended options for the file system.  Extended options are comma
-separated, and may take an argument using the equals ('=') sign.  The
+separated, and may take an argument using the equals ('=') sign.  Multiple
+.B \-E
+options may also be used. The
 .B \-E
 option used to be
 .B \-R
diff --git a/misc/mke2fs.c b/misc/mke2fs.c
index 3a8ff5b1..a54f83ad 100644
--- a/misc/mke2fs.c
+++ b/misc/mke2fs.c
@@ -1653,7 +1653,7 @@ static void PRS(int argc, char *argv[])
 	int		default_csum_seed = 0;
 	errcode_t	retval;
 	char *		oldpath = getenv("PATH");
-	char *		extended_opts = 0;
+	struct str_list extended_opts;
 	char *		fs_type = 0;
 	char *		usage_types = 0;
 	/*
@@ -1751,6 +1751,13 @@ profile_error:
 			journal_size = -1;
 	}
 
+	retval = init_list(&extended_opts);
+	if (retval) {
+		com_err(program_name, retval, "%s",
+			_("in malloc for extended_opts"));
+		exit(1);
+	}
+
 	while ((c = getopt (argc, argv,
 		    "b:cd:e:g:i:jl:m:no:qr:s:t:vC:DE:FG:I:J:KL:M:N:O:R:ST:U:Vz:")) != EOF) {
 		switch (c) {
@@ -1796,7 +1803,7 @@ profile_error:
 				_("'-R' is deprecated, use '-E' instead"));
 			/* fallthrough */
 		case 'E':
-			extended_opts = optarg;
+			push_string(&extended_opts, optarg);
 			break;
 		case 'e':
 			if (strcmp(optarg, "continue") == 0)
@@ -2615,8 +2622,9 @@ profile_error:
 			free(tmp);
 	}
 
-	if (extended_opts)
-		parse_extended_opts(&fs_param, extended_opts);
+	/* Get options from commandline */
+	for (cpp = extended_opts.list; *cpp; cpp++)
+		parse_extended_opts(&fs_param, *cpp);
 
 	if (fs_param.s_rev_level == EXT2_GOOD_OLD_REV) {
 		if (fs_features) {

-- 
2.45.2.121.gc2b3f2b3cd


