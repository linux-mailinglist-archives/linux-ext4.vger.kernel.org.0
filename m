Return-Path: <linux-ext4+bounces-5944-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA26A0371C
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2025 05:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E5BD188536B
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2025 04:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B31176AC5;
	Tue,  7 Jan 2025 04:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8DnBly5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80EF770FE
	for <linux-ext4@vger.kernel.org>; Tue,  7 Jan 2025 04:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736225231; cv=none; b=NZ8ENZt2r9k9a5bPXkdS9JiwKCnhvhU1eFW5bFjMuWXBKGJITlVJD395Vy+A3VLBs1STTxikrY83SKyq2qwqGraMSevlpiHoaeWWOH8ojqPycYKtnYOmujB6TRXNkUXvaOocf3GfBIFDOzO81zNvqvVwmj2A0Hj6vBGX34v8Nic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736225231; c=relaxed/simple;
	bh=oFg3j1pWZA1M6sZX8lwCUBQrNti6I9neNIzc+AjBHgw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oxislbDmUDBVPReGDuMaUHmJcX2Y13qQF3VBGWJ0Q0+lSqMW6pEj1i3OdYCFkoJwR8nIw1xrdpIRVuNfUKjSsgzmQODIlahOX7hQqVRk3qTpxO+Sk+N8OwTl5zNDKkHzj458ahNbAxjVlnl4JLYi8FVaQJoULC8z0nkMaBVHY2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8DnBly5; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2f44353649aso17903992a91.0
        for <linux-ext4@vger.kernel.org>; Mon, 06 Jan 2025 20:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736225228; x=1736830028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oxu/5vf47VMP28lAF0LxyOANce+/SaquXrkx8/Lbl94=;
        b=k8DnBly5v0Pt8OvTHmAiLWc3KjqKfQWN7uOUzmQpWaIJI2dEXdKPg38OvV2BU9Skxh
         1lu5PXzZRAmEfq74KAuXgGPLEEDNYiA8/Cmm4Vv0OudXUdHPA4F3BtMT9k5+HruZJxKa
         XPaCVqLgcldKCk0I8ULJCVMYJWXWvQqqYg0nPZMoQBnmJwmUtEFBS/KF5ZZn+LB/x2mA
         i/3znVK0660BrEZHqyb1/0clRNM6d91tXwAAukh612iy+hRfeGYOYWmvql3GPx3c1AdS
         FBl8Z6rRoxAvdON2zZc+GmNpa4XgdlvoIXqGZhv3gQIQrs7+FwtwVG4N97YFUrMnvlxv
         2fIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736225228; x=1736830028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oxu/5vf47VMP28lAF0LxyOANce+/SaquXrkx8/Lbl94=;
        b=mzuyb868DdXPIdc92WqAHPue5inEwn5ZbhGObdIs/75B7SLfHXpPPw5Rw355wAJ7BO
         W/dEc6/d0hgtFPHCbiGqwQg4eRfwESeDfqezOA3cANyIgv33zmzL3if0ICBGQsBMWqXy
         86GZqdtNdRIsrDe0oDAL4Re2DYgAJ6Qtlvdhow2exzpHTHN8jKzd0I2p+jBtj7ROXB26
         Akvk8KCnzI/BBKn2c+YWNlPt0LudjEwX87Qy6Jq2Y2PtuP93Auqk1Pvz94xLX9lO6mbG
         OuNfteft0N6zNlc5flwAOFl1g0N4sCVko2gh063MTpsO0WcL2FPYfdSnz8H0Cl9rj626
         9Xpw==
X-Gm-Message-State: AOJu0YzF3OELZ37Eyy1L1Q35/xRDnU0hQSILra87wDLmizkeiNOdHOaF
	MX0fsgQs1kUTddpb6mk9M9qpVrhjAjZwR596/rHwMyLXOf8/UMynNqTmRORF
X-Gm-Gg: ASbGncsYXb1E3M1rlkzi5Vc3JsW96KLXSvwHtOeUelP+XemcS+sIL5jC/KKqNhoNDEi
	4X91IENjKeC8ymOgHjKVS8Dv1+9OgnPBPnNA5NjFShASAxwinn/UKLrRwitcqXv4mfG1wqzBAm/
	YdeO/2+RAQV5lhVe3YrJeobDrpRe/aGeI6ELDW/vSDkONiq/QHuk5f0KmCweVA5kHxWbop0/ZJh
	iBqcbUxwmt77Venn4ijqJTMHUdkmKiicts5Ca6x5S+yH/yf3qoyxdlrdKTRcw==
X-Google-Smtp-Source: AGHT+IHHRnQvyivRNsdLxbb/+yG5MDrRkDGRFxLPx/TsFvipK1hVdlIn+vTE3fOVvE5MIfuRaj/DSA==
X-Received: by 2002:a17:90b:2b8e:b0:2ee:3cc1:793b with SMTP id 98e67ed59e1d1-2f452ec6ed2mr77499505a91.26.1736225228455;
        Mon, 06 Jan 2025 20:47:08 -0800 (PST)
Received: from localhost ([123.113.100.114])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ed62e390sm36733967a91.21.2025.01.06.20.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 20:47:08 -0800 (PST)
From: Julian Sun <sunjunchao2870@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	Julian Sun <sunjunchao2870@gmail.com>
Subject: [PATCH v2 0/5] Some cleanups and refactoring of the inline data code
Date: Tue,  7 Jan 2025 12:46:57 +0800
Message-Id: <20250107044702.1836852-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here are some cleanups and refactoring of the inline data code. Please see
patches for details.

Julian Sun (5):
  ext4: Remove a redundant return statement
  ext4: Don't set EXT4_STATE_MAY_INLINE_DATA for ea inodes
  ext4: Introduce a new helper function ext4_generic_write_inline_data()
  ext4: Replace ext4_da_write_inline_data_begin() with
    ext4_generic_write_inline_data().
  ext4: Refactor out ext4_try_to_write_inline_data()

 fs/ext4/ext4.h           |  10 +-
 fs/ext4/extents_status.c |   1 -
 fs/ext4/ialloc.c         |   2 +-
 fs/ext4/inline.c         | 199 +++++++++++++--------------------------
 fs/ext4/inode.c          |   4 +-
 5 files changed, 75 insertions(+), 141 deletions(-)

-- 
2.39.5


