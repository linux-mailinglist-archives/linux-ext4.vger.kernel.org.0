Return-Path: <linux-ext4+bounces-7821-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 699C7AB4DBF
	for <lists+linux-ext4@lfdr.de>; Tue, 13 May 2025 10:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C8E8C1073
	for <lists+linux-ext4@lfdr.de>; Tue, 13 May 2025 08:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1191F5852;
	Tue, 13 May 2025 08:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMfkB3Mv"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EF61E491B;
	Tue, 13 May 2025 08:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747123953; cv=none; b=JkdW3c7mjIck1zngkEMc1SeerFkCieB8gwsDyuJZUT1LddWv3GYxSq9EhmGgjKfLUh2fGM1V4pvFIana57V6rgs2//frZl6283yxQM0fN0SQTxI06AL+KLrDuSBsCkIQtd+lpH0E1jq3nLYafm/Y8EaoB3D1FPlIALTpz7/Ox1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747123953; c=relaxed/simple;
	bh=lUgGnSRxuVXGr71NgRFCjlw9BHFBEQ+XkxniRukkDWI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=btjY54AVKx+qyZ7sbiv/grnLp8TZJB1G7miSz44CaprKionOSeESO5Oa2tCD5m78wJ8u00ez7gTDx6iviHXg6PsfUM8ZJPwdvAmvBm9Y/8c6L7yCBZY6+0XITCJK2o3VSfU9huOi/z/+bt9QRQvMLZBLwqqLIQiz7flMr18kG+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMfkB3Mv; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b1ff9b276c2so3219999a12.1;
        Tue, 13 May 2025 01:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747123951; x=1747728751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P6Rb03ikU9vADQfhGnIl1VSs05rPOGlPTucSrp8IlG8=;
        b=YMfkB3Mv8g7ntxvmb0pKmDjeOlZpo2rWDb8fV0xlQ8gSTYBVbQGWyE/GaEgwC3rtQo
         1/WvDzcaJZU0gpwe6aFbPma6MmRnUnoXg+R8uBrY/k6xLh3LTH48aI0mUDZlPVWv5yHH
         dJkkgzTah9naE21zAZeLl5BN9dLkDiCRag8KcTPwqnr7I2/h/yMLyEQRsJqHN458hM2m
         2pRhTTAzS9csx4o0N4OrDfFCwM8vjaP1duslWyWOwKlZ5hGvUfcFo8d1qjbFCRv442SO
         f40LBiFUYVWQnxQn4vvKBpK6zUC650SChGbf7obUvH32LMr/1xArPVNzjzki6NZaEU8k
         kbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747123951; x=1747728751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P6Rb03ikU9vADQfhGnIl1VSs05rPOGlPTucSrp8IlG8=;
        b=pRmGWK14wrK/wxmEXgDWukpDqYVqDG4/3iqEojuBfDyiIH1iu5cWsY9QoN0vhKp8G4
         ksKZoOPW76b07lSBkEGL9pvUrqX6kelmQ5K4CNv2/yrx2RdjMQK1LZ4MZAXIaG8oCa+J
         MikuAyi9vpTFlAFqPcwZw8+s59Enm0lhITGpNJavDORur6x2h+cDB/EDwpn/z1uXeRE0
         PMx7ndudGoORVDviGe3qLPF5MH4TS0MpmQy/pozJc4Ugc2zxfCFuoFF1VcttocLNaY42
         WgGfcPd9qKTX1FAkRSyGPASL25BY7q7L1yBnYtHKn1Yv1dG8nhDzFO5l/qyVM5Y+7kzs
         hmJg==
X-Forwarded-Encrypted: i=1; AJvYcCUgDvFKz1BklsKa/nnsvtbD0n2myvBLA8NroFAfOrYXTPDH+W3JpUXe6zeClZ6oKuQrJfMDP0YVUSM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv/FZhEYRy5sNH1PaxFqJJ+Vv1xQe/tmeL5oJ9LxwqqH4rk4G/
	TWOUuU2Mh911StzDLmPVNVIgaZSEpCQkTEjMNwAzuyd5AhQ58tOaZQh7XA==
X-Gm-Gg: ASbGncsT15wUPOZ/HHXCv3ijJPnTPmgDCzGEzhRxzYJe3r6Zk6C6uazPDQPjVI8eOjF
	r5fRT/PeNkFfNsc2EzdYIyy+aueQXz2pyepyrgV+eNUMUgV06vyWd+GH9IpUJZhTDKenqPTjge1
	zBEFFI2y0+zZYZ4OJVCic6LEp6zPn7li/ON0KHO4mngTSgr+AJHoXkYaGjk6ySXgCVnHJSnr9rU
	BHtFORHQzlkl8EiRcfztw873YVVTxZqhu0NwXYuM0Ybr8gncGiPMKdtBkaHqrQRYataEl7DVBI9
	JElc5fYeLjK/C9QTJCarwkhnvsDQaq9OyFy+T8c9ABsJAfKqXN/Sdnw=
X-Google-Smtp-Source: AGHT+IE+p/O9ti+xWr+VkNa4E3WEpb8k7I8DaSthJSV4LqVkeBnzi4049B3JurtyvqNHl8wTHW7L1w==
X-Received: by 2002:a17:902:ccc8:b0:22e:50e1:73e with SMTP id d9443c01a7336-22fc8b3b3aamr234565005ad.14.1747123950703;
        Tue, 13 May 2025 01:12:30 -0700 (PDT)
Received: from citest-1.. ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc75450b6sm75896585ad.49.2025.05.13.01.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 01:12:30 -0700 (PDT)
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
Subject: [PATCH v1 0/3] new: Improvements to new script
Date: Tue, 13 May 2025 08:10:09 +0000
Message-Id: <cover.1747123422.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a couple of improvements to the "new" script.
Patch-1/3 - Adds an optional name/email id parameter prompt to the new script while creating
 a new test file using the "new" file.
Patch 2/3 - Replace "status=0;exit 0" with _exit 0 in the skeleton file in "new".
Patch 3/3 - Add a make command after the skeleton file is created, so that once
the skeleton file is created, it automatically gets added to group.list file. This
will enable the users to directly run the test without having to explicitly run make
on their own.

Nirjhar Roy (IBM) (3):
  new: Add a new parameter (name/emailid) in the "new" script
  new: Replace "status=0; exit 0" with _exit 0
  new: Run make after adding a new test file

 new | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

--
2.34.1


