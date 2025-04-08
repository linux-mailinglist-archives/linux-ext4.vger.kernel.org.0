Return-Path: <linux-ext4+bounces-7106-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2E3A7F43B
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 07:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21CAA1897F8A
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 05:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0011125F79B;
	Tue,  8 Apr 2025 05:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQpY2N6R"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F3923ED60;
	Tue,  8 Apr 2025 05:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744090746; cv=none; b=VeeqhFXtmQspkVuTxsJREZ4qrFs0gA3DSLjwgxaIU0fq7q///MlhBlbJuuYVykRUWB3/9+zPyrQU7RGhkYyuSx4OPGOtB5O5FTJDge6osYhGni39KcHlzTqlmroJ67F/ouDVXhNBgvl+bWA4VRK6zsFywfepl7Tn/3l28ndzYbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744090746; c=relaxed/simple;
	bh=UYu6HmxJV/W2xYboc9hw+pRk3iS2oS600P4T3AipMfk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oESj5Vn4acfuoa6yY8ngFeTx+o3S9DJdCV5G7fi2psmLi603/HS9sVS6SzjNJ57whaSr7j2yzRpshKpGQ51E2JqyiAJRYnQzRJeITinTXgudpqXTBmA77ZXdxL51LkB/YKn4dYJzt0yWoyoCh/H/cwTVnGbPstVJf3zTpgW+UL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQpY2N6R; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-224100e9a5cso53435295ad.2;
        Mon, 07 Apr 2025 22:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744090744; x=1744695544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nlrF0gn18F27iCXa8L+ViuBunMmlWxBItiMs4cdAys=;
        b=GQpY2N6RS2rqBsi664213gHtjnN5y4aBp7ABAd891UpukmGmXziokHPcckGOGYZIdw
         aNnt8JEKpOmwiTAwhozcXjBzg3PHbIv3MkA+2JrL608aWO5xV6cBncdo932XgCm3ZMk1
         zRkZndOFkAoVpQRK5NkuZxXElUkgdV55H5GOzuvhHqBefaRrlXHeXUDkVgHp7BC4vFno
         1fWTpT+PNIyaxpoDMbiLJ0+qaoX9peNGFM5uzrIHqV0Lb43zi1Ix5TkG5KyR5knmIJ8x
         66nIHh1bTOCBaP4WlWjaMHAkEFRJNH/8Wp1C0nJ0VdkgguVcghgbozny0v5gfO3/MsgE
         SyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744090744; x=1744695544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9nlrF0gn18F27iCXa8L+ViuBunMmlWxBItiMs4cdAys=;
        b=OGPOM/qR/7WWT9RSjUrY5fx9X3VrCCypEo6eVmUR/VaNyYcJlb6t4bxhCalsoYFygY
         Lz1GRLRjCwNU04jICOTCApRz9x/j/HTvsvpTCJ52mgE1S/ryT9HXisuDxZ0Po5C51sZq
         N4BoF8hf5keCsq4yNWCfRZAXlivxV1at3wz9aqQ0H9GEShZJSWyQsog6MqQE3K6fVoOJ
         IYLfhywh1UTW8CO8UhJ3er+1WbZmGbnhQSW4OsTfSdm/ETwj1lVk7NR1jeWJBy58M0OS
         sWCgkbv1F88a4roy6wQs53SmxraRidXB66KddiB+SZLhS5KONhBlhQOrzOOvwfSt7qMJ
         RJqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5Q7ZFrp+fUNIWoOnPR5rbjS75NoJqx85GqtIse1Z0DYpvt0pMnj+Pg1KZOlvgN0iMjn4urrP1ELc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdOVVfBO4arYg/eEfHCBL8kG0oUjNVoFMer1W/t6/pFh/EdYY4
	oEQNJe7kkSu3/ByTc9OC6kYnYh9/z/lvb0Tl1SgNYweVue2er1cUxztGOg==
X-Gm-Gg: ASbGncv+1bBaXxGIrAeGdCLk3Yrx9CQnogaQRGbMfS0EeFvtHpxQUsM/EUMCWrc9ghA
	6cTr3Ed0kG3v7gnOqrp/FBSybCcdyApXzJr9qeCpdZjrpn3TH62nG2+JdoVnPudmRKUXukE7voY
	UnPZqEK2VBpYdksr+lz1P6C7mSJYvVC8/6ailU/g6rrBRwg3wI2eQqodLlfC03jQikB06sxiMVY
	UunNmqujh+8NomhZhMipTOrCTX+HZZtTH1dgkSiIoo7A9c7Wmt9lk1zzPV0dp8Kba4buLf8j0EV
	Cr1hv1pPLDmV655OZ4u8LC/Ig+ePlw4drg3VMbPAfJEuQlL0
X-Google-Smtp-Source: AGHT+IH5I/69t6vBbjr0AlikZ1hQkgJiVX6v6Mmtc8tnCI12BG45Esls4acH6Jh/Un3j/I/8qRYrXA==
X-Received: by 2002:a17:903:292:b0:220:df73:b639 with SMTP id d9443c01a7336-22a8a8ceb8emr230257475ad.36.1744090743837;
        Mon, 07 Apr 2025 22:39:03 -0700 (PDT)
Received: from citest-1.. ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229786600b1sm91154875ad.109.2025.04.07.22.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 22:39:03 -0700 (PDT)
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
Subject: [PATCH v3 5/6] common/config: Introduce _exit wrapper around exit command
Date: Tue,  8 Apr 2025 05:37:21 +0000
Message-Id: <352a430ecbcb4800d31dc5a33b2b4a9f97fc810a.1744090313.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1744090313.git.nirjhar.roy.lists@gmail.com>
References: <cover.1744090313.git.nirjhar.roy.lists@gmail.com>
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
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
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


