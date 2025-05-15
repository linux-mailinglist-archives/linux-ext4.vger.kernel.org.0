Return-Path: <linux-ext4+bounces-7909-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AB7AB8479
	for <lists+linux-ext4@lfdr.de>; Thu, 15 May 2025 13:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AB4C188F18F
	for <lists+linux-ext4@lfdr.de>; Thu, 15 May 2025 11:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A042297B6E;
	Thu, 15 May 2025 11:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNiDmL/W"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962541E834B;
	Thu, 15 May 2025 11:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747306902; cv=none; b=Smhgv14if10FcGIiz9BAiuL5JtJlfniFyfk2pIdh3iHpZMfB+7QAwKoaUhhSsq1OgYuQYWYUArS8dQm8b9FCkkzzemWCefld5/Lc6rdL2wtOifEFwAn97S9eCooTPXaC1avaDCvI/9qWl/+Dw/5N6TkCLMHrTrDwVv+R/8MUE8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747306902; c=relaxed/simple;
	bh=wIf46AzadrdmTfpzoaNl1nGfBM8lu4JXgtWjKvj99Vw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MOXT1Zwb9pEJOb2vs4hBqavZMU8EYtjLzzoi12Wjxix2iQjrPGd57SLXDEBoEk/fCSKGf/olFCRSr2szOWi+hReZnH2pcIQqOLuZJGWEVHmaXiYRXdFzYlHoAbULNhFxxtmN5T+bacIyHBLVmD4lIt/uVyDrgh9ueG8Rn4jT7F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNiDmL/W; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso877727b3a.0;
        Thu, 15 May 2025 04:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747306899; x=1747911699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llW0v6NlfABY3dyBRIi4uqIS2MOVS4HMom9kYXMUNqs=;
        b=PNiDmL/WIoyGgvyzvxfgb4MTLanAHhZuBig3PocfmcFKtyqss5d39hA0CFOwY/cFox
         L82t9SnOXNn6HRx5PB6CqYw727THHkn7tcFAz8eFytUwAI1p1e/0L5b7/ggcqEO7pOer
         CMMJdyt99nac9nd1CzdsQj28HNQH73mu3jp1XzsoqOCWHXQw7PTUpAix5p8QwffjBn9P
         t8E+YH4S+G/zgpW41oH+rYXi2jqToJcztuKnFt7LqQ85Tvpt5lWBDXwF0OyGIu2SWt38
         AG8GiUwkUAKddlxXPKFvgmSw07hbMJBfrf9ut81JF76zsnQKIBjApzPBr5mQ1hB8VZUq
         t9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747306899; x=1747911699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llW0v6NlfABY3dyBRIi4uqIS2MOVS4HMom9kYXMUNqs=;
        b=euyor7b6JyxVawDPe27cskRDzqepRqu3QUlfCr6JN2dPL1JkaIw6+kFsZRE8sJ2Eft
         /JF/C3qStPtwcU2VYs9p6MqLTexzkbR1O1MVhzk2/vQEXBgD0R8MkHO76ytpikeCOCWO
         oHz6HLf8Lmxl3JxAZm0RVsPsx0dGyi5h2z3GORvHbhGhlYE9zfOYsOHbKrf9JRF5Ytko
         0ZqlEbYl4PRdiRbJFn8Rrvp9uC2RfWgIyF8L48F5g9+K+CIBltqTAo2m77KUx03IKj63
         5GN/Fuk3FqkosfTRR3oQfe+92KVFOcsxgkdgX+IFg6iJ90HkoCbrLhrHYwxwOd2CFQG1
         sINA==
X-Forwarded-Encrypted: i=1; AJvYcCWAc0keqbrlCdRD4YYDZsNqoku1BUYzBjtZqyJnPL7l2jTzalJvTs7+8Dvk9UrY/M+U0KP6nNVGQlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlxA1yzFRY+uUmv8rco5KnjaSvpZ+DjywqOvFkaop+ZRhwNwcB
	z+tiicyvIoci7TFRTzF8ia6s1GwrlPnDvw7QBVBtBXpvqQqdK06WRWiW2w==
X-Gm-Gg: ASbGncumVNwbE0iCc5MzP1zY5pvRQdckEJwyN1kOsKBg7y2GdhIdMU8mNKgoDr2mGgV
	A+OfnFVSk9JIpy06NxLXhNNRVx+TVSP3TiMJXW8Qrv25NQo9QsTaz3S3E4vAxyGGdKb75T65Rv2
	eZ+LNROdlnhU4aig/3Csb7Lj4fXIatRLUoPZBi0iypT0/KFvt1Vznx2UnaCYFha+0lRoCk8Ay1X
	cZx/9PbA81dV7m3u8L8JP9aK0iUTa0m40Izay0vL+EBKsn5v584KCy7jrhpivuySq0+NrMTp9R+
	iV7UoZJQW5Lg/Hrk0fJCmnKWhtMby7/ymuZM2Ia9YDw7OkVvJqVlWOk=
X-Google-Smtp-Source: AGHT+IFl5KnrMLofWQ/tbFSRo4TPNBZiDflrUm4O4zbVAzoux6qv+9AsAKLRwngZzFg6lde2RcKV7Q==
X-Received: by 2002:a05:6a00:ccc:b0:736:4ebd:e5a with SMTP id d2e1a72fcca58-7428936af7fmr10532347b3a.20.1747306899294;
        Thu, 15 May 2025 04:01:39 -0700 (PDT)
Received: from citest-1.. ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7423772752csm10733673b3a.45.2025.05.15.04.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 04:01:38 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	david@fromorbit.com,
	nirjhar.roy.lists@gmail.com
Subject: [PATCH v2 1/2] new: Add a new parameter (name/emailid) in the "new" script
Date: Thu, 15 May 2025 11:00:16 +0000
Message-Id: <2df3e3af8eb607025707e120c1b824879e254a01.1747306604.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1747306604.git.nirjhar.roy.lists@gmail.com>
References: <cover.1747306604.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch another optional interactive prompt to enter the
author name and email id for each new test file that is
created using the "new" file.

The sample output looks like something like the following:

./new selftest
Next test id is 007
Append a name to the ID? Test name will be 007-$name. y,[n]:
Creating test file '007'
Add to group(s) [auto] (separate by space, ? for list): selftest quick
Enter <author_name> <email-id>: Nirjhar Roy <nirjhar.roy.lists@gmail.com>
Creating skeletal script for you to edit ...
 done.

...
...

Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 new | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/new b/new
index 6b50ffed..636648e2 100755
--- a/new
+++ b/new
@@ -136,6 +136,9 @@ else
 	check_groups "${new_groups[@]}" || exit 1
 fi
 
+read -p "Enter <author_name>: " -r
+author_name="${REPLY:=YOUR NAME HERE}"
+
 echo -n "Creating skeletal script for you to edit ..."
 
 year=`date +%Y`
@@ -143,7 +146,7 @@ year=`date +%Y`
 cat <<End-of-File >$tdir/$id
 #! /bin/bash
 # SPDX-License-Identifier: GPL-2.0
-# Copyright (c) $year YOUR NAME HERE.  All Rights Reserved.
+# Copyright (c) $year $author_name.  All Rights Reserved.
 #
 # FS QA Test $id
 #
-- 
2.34.1


