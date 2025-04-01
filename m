Return-Path: <linux-ext4+bounces-7028-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C930A774AF
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Apr 2025 08:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEBE216B210
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Apr 2025 06:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548F11E102D;
	Tue,  1 Apr 2025 06:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ls0hnRSB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAE74D599;
	Tue,  1 Apr 2025 06:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743489917; cv=none; b=ZSss/GYXaAykhYEY4dH4E0IH7Qp8qD3z57fHupfh3y8mN5cht2FhhYy3C/HCu4/tFdiJlM5YW23H5qbnFuJTfZyIq9kTJcU+WUQ9LknoG/u3YXgKEno7IFa9efy44lv0ipsAKiQLzdM6v81j2tI5c86Cao2eBy7m5vf91TvvNhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743489917; c=relaxed/simple;
	bh=jMGCpMeYgueXGodMZgt5uAMcpsuZuTOcSYUQwJvFoig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hspHaYDZK8SodJZcn1+gEeU9F/Y9sYoXvP9RSHR2NIc89CQ4OrOdeRRPAG5I1feVjjFEQfxSFiFO4hSOcDbjNEOuOJSy4VAXuoFxgvklPsDYmMo/Nswk9Y1xmjJoXS6MWrioScFlaBHWgTKi3YPEVOVDQ4kua6i3wVp3OvBz4CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ls0hnRSB; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22438c356c8so101665275ad.1;
        Mon, 31 Mar 2025 23:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743489914; x=1744094714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+RCkWUSMjxNmaTFzdQsP3/hq4/SoQWwDMZZ/WKYtRA=;
        b=ls0hnRSBeUZMyXjlMJ/PBofEWCUns4ExgdMiGzBjmCfATnF+hNoxu4UZh4jRCnYyqU
         +hBUpFnhSoXuSsRorZ+Mi8olaj87m+idtRLVGTMXXNZZx1IhXPtuf7TYDOb2tRFdUpAI
         CRgsdzbVJjgGXCJyr+H5fc0MYJIltGjVn1/Mg6tlue+dLOgr0V7EIzOocMutGaYmKZeM
         y+R5QGUI9FpN0ZwU2iS2TKu3vscrIMKZJ3EtCBFu2/Nm9pNCWGLQ768N/PPi+PWUTRs2
         cLA5D+yHwxRTnTh1aXK7RriIy775ef3dHG26OUDxeeOAka/8q7HnejvffrlPZHaYwD/7
         Tj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743489914; x=1744094714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+RCkWUSMjxNmaTFzdQsP3/hq4/SoQWwDMZZ/WKYtRA=;
        b=foR7rtrB+vxxJ8aQc+VOJTY2FcmaN6eL3w2zMzi09w80VO6IXINVQHXNAxho+z+WC7
         RCfHXLMzbf6PGCn1l4c32XCAFcnYo6keHvIpzLHQgUMITJYtlUJZ8wqJMXTcC0Rkfm8y
         P9zR73k/G+1HwWRw5GrzwtZgpjEArZYTFST3+czSaLOr/iQtunHbyET+R1/oDbLAAyZI
         IXCVsAT5rj4NRB+vLzIoL1zTVewW2xfMG4gL2eXf2XrsQzYycake/tUMNqkyW0t0jq+f
         5T7y7ZQugDVQnM0M6DLuESUYIRBqvoKATYjI7RMe/KrY4Z4ujrY9JsCBy/nDz8s0Wc9z
         BRFw==
X-Forwarded-Encrypted: i=1; AJvYcCVCnc2oh2fakv7lGh7um0Lw+jfXekpaRnKe2PXihyrUQ9flVXwTMxxnU3d+Jp15qR39PByd1zXz9KY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC61BHLstjrSBbg7IpL4RAcbQBBMjb3O31ASTWT1nG3UvJFiyx
	ZCLDDW50LJDI0VIhsa5iulIlMzpdOPEI8WEvHbqzD/L79e9r7TWYnhuXgVoH
X-Gm-Gg: ASbGnctV0Wbyewn4pXLIeqLL2Kt1Qr5BJHulJjz55gSGmzVpO/CKYkzKQzhQuCiE9s+
	rkie4NZhsEtGq2N6yBwz7d6FRqWO5nME2ZZJk8InWHFTuJnmE8KAZzOdDzvf3OPHNYTK0lb5MtB
	wgWscTknivL1hJ/N/yRaHR5O5hNV/YJPGPJw6h/2e7m3MOHKmE4jcGTHz5VBX2A7cQycjKBMu5J
	//zohEIGsxrbliqXajeGzNR+LRE1PtVJ/BH/Tn4494Yt/ffxAYe8lC0e6VsrdVBzoFwfVwrPX6Z
	qPWgM/F73BKHZ/PxrjkhoyuWv7prblXIFKjpCjZ2V0HPNLo5
X-Google-Smtp-Source: AGHT+IHjkQCCQZdsjtZa2xCgFAeNEtTZL/bdP1koTdN6JTpYL0KGOxQLFSZcL1Itfow76XHx2TDdAw==
X-Received: by 2002:a05:6a20:cf84:b0:1f5:7f56:a649 with SMTP id adf61e73a8af0-2009f604630mr21636843637.13.1743489914452;
        Mon, 31 Mar 2025 23:45:14 -0700 (PDT)
Received: from citest-1.. ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7397106ae4asm8135092b3a.110.2025.03.31.23.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 23:45:14 -0700 (PDT)
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
Subject: [PATCH v2 4/5] common/config: Introduce _exit wrapper around exit command
Date: Tue,  1 Apr 2025 06:43:59 +0000
Message-Id: <80bb7e56ff00101c6bad6c882da631a20b09b6ad.1743487913.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1743487913.git.nirjhar.roy.lists@gmail.com>
References: <cover.1743487913.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We should always set the value of status correctly when we are exiting.
Else, "$?" might not give us the correct value.
If we see the following trap
handler registration in the check script:

if $OPTIONS_HAVE_SECTIONS; then
     trap "_kill_seq; _summary; exit \$status" 0 1 2 3 15
else
     trap "_kill_seq; _wrapup; exit \$status" 0 1 2 3 15
fi

So, "exit 1" will exit the check script without setting the correct
return value. I ran with the following local.config file:

[xfs_4k_valid]
FSTYP=xfs
TEST_DEV=/dev/loop0
TEST_DIR=/mnt1/test
SCRATCH_DEV=/dev/loop1
SCRATCH_MNT=/mnt1/scratch

[xfs_4k_invalid]
FSTYP=xfs
TEST_DEV=/dev/loop0
TEST_DIR=/mnt1/invalid_dir
SCRATCH_DEV=/dev/loop1
SCRATCH_MNT=/mnt1/scratch

This caused the init_rc() to catch the case of invalid _test_mount
options. Although the check script correctly failed during the execution
of the "xfs_4k_invalid" section, the return value was 0, i.e "echo $?"
returned 0. This is because init_rc exits with "exit 1" without
correctly setting the value of "status". IMO, the correct behavior
should have been that "$?" should have been non-zero.

The next patch will replace exit with _exit.

Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 common/config | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/common/config b/common/config
index 79bec87f..eb6af35a 100644
--- a/common/config
+++ b/common/config
@@ -96,6 +96,14 @@ export LOCAL_CONFIGURE_OPTIONS=${LOCAL_CONFIGURE_OPTIONS:=--enable-readline=yes}
 
 export RECREATE_TEST_DEV=${RECREATE_TEST_DEV:=false}
 
+# This functions sets the exit code to status and then exits. Don't use
+# exit directly, as it might not set the value of "status" correctly.
+_exit()
+{
+	status="$1"
+	exit "$status"
+}
+
 # Handle mkfs.$fstyp which does (or does not) require -f to overwrite
 set_mkfs_prog_path_with_opts()
 {
-- 
2.34.1


