Return-Path: <linux-ext4+bounces-6661-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71223A4DF9E
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Mar 2025 14:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451B217347A
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Mar 2025 13:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B26320469B;
	Tue,  4 Mar 2025 13:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgnJlaZb"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F331F1FF5FB;
	Tue,  4 Mar 2025 13:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096122; cv=none; b=DD0NmoSAFmY/MwqRxapqsUEvt8rMUdZyaFfqTVPjJZYcjYPb9scrdaDEtRIAvoO4dHvmK+Iltfmkn8ZMyDSmXNnNTBB4JaXL0LijdL47OlIj7O6OD0O/lAjtbrFrbnSub9WCoCPtz27Fx5tl+I2yMb1fxnVLdPNVHYv7k/ZBYX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096122; c=relaxed/simple;
	bh=pwUV0/+bDB3pe+QvVJn9/f5sjo5oDLLc92CR+fO0/yg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yea6YAhpLr2qxbCy4MxLEWHa+yFR/UxftFweOIsCa2V3dCsb//3vnu8mAP6rpB3sxBwJ+u6eN9mOPV1lzFd2e+QyRgn6mk5kWU5Xb/sGqL+AeBiy6vferL1+wHQIxz764U6OpYjZhjM8ztCifRVIQbjDC/NPrgTcIdxXtv+nMto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgnJlaZb; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22359001f1aso125954835ad.3;
        Tue, 04 Mar 2025 05:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741096120; x=1741700920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f3xFEkgHSKF8L2cfXSnWsem3aekOfXeR6ghSzlQMiGc=;
        b=GgnJlaZbOcIqpGRsjaUCp7O+YIp3fNXmbCXJiyblQw71TSJHBU9jDSWwcWbixXbKeh
         zbNMi/DLJLCYVXCN9TYrAMY84FCDPrwbTLRBaCIXH1JmNIuDutG3BMhvXr8YCMfj22Sb
         m5LNe+zovD6b6gEUIZNNmn3qWWOC9lOElg5OZN6042m/M+uUlh4bR8ouMuAT8Etffsn8
         cVkdmskSOwcF2KHmcUZ2mq6RG9k+RgLP+wgk0wRmZOH2QcPW1P2LEmCY2dkzNM1Ib9AY
         YySLe4aNriO3hwlkGfoxm/BfDH7dyRKioN9km8cUvcEeQ8W/kRvcNab7WjKe3csakW6H
         DR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741096120; x=1741700920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f3xFEkgHSKF8L2cfXSnWsem3aekOfXeR6ghSzlQMiGc=;
        b=ikYY6F0bJlvYHuDQPmXie4FPaYy4FT5x63NexEiOrUg8K7hYwLp3QyGyD4DSbqS9o2
         LFFrGImlehDCAR+cfWOGBpU7/hNU6v/8UGyEKI7NTjl6lhLuSRtdYAnxr1+TFZ1NXIbV
         hiPBHOYRPmTDzKKcpjcOD8ujHvmv6xTnEDd0nHYbEQi8hMlsuHQFYv8eo0EvjFzwROVy
         2lOWHZwn2y+IWj5y5YWnvI+d6fCp7Pv/St98pYyKmyietb38LNrX8XFGttn31JrIPJPe
         3wxNrzkm+9eAh6gftVYHAwVluqW0NqM2S9Kv4dpBlQaPU05DqwNBeisp651MbtaPeH95
         +XWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWO3yfXI254G96TAX8mfbgXhVHSJ7QDNvrrMl24kjWF/d6O1FFaX02FUWTP4FJ2zIwBZxF+IqYO8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YymI0VaCJBcrlpEkLCCvYefDiNSeUrHLn90YSkZiXvhH3MZujjz
	RvRmQxo3tmnfM1qxaJK7fLasLc0e5Q6W9znsmyvpXOamHASfKeu31KPTJtwe
X-Gm-Gg: ASbGncs6rxfmZxVb0eVEQgIAKzOFAndQ4VlSQsazn4ry9/6wH4PLdsOz8645MEnPdZ7
	wT7phJ8N6cNSUQ0TsdND5ycmHCo75mAxwgKeP703Xl+og9adm9UVMzDD9Ka0xsd1IYsxEEZd36w
	VE1wFjdcuPqyboxx5eETHbtxX59dS4jA/KYIsAx4sAQA7H8IXBepDl+NbtLXuNFbQoyGKyQ3CEu
	Wo3Ro7n8X1EIo0fj6N3W5l12qAVjHmKw1S+pUmz7/0krtQ4gspMQ7HIgWBu3rIr6Zv6F3CWhx6x
	T/4wiP3bcSsWrWXlIHp0FMZfwqR3NYZ4hWVdwzNi9HzxkQ==
X-Google-Smtp-Source: AGHT+IHr/Sb2GdMUSJMQ5H+k6UUTsZ/zpr5p6kRYZU2cQvoyd7rKbUoS9VQ3IBlYXqYxXn7kXT7VZw==
X-Received: by 2002:a05:6a00:ccd:b0:736:43d6:f008 with SMTP id d2e1a72fcca58-73643d6f164mr16518488b3a.12.1741096119727;
        Tue, 04 Mar 2025 05:48:39 -0800 (PST)
Received: from citest-1.. ([49.37.39.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a003ecb6sm10879106b3a.150.2025.03.04.05.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 05:48:39 -0800 (PST)
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
Subject: [PATCH v2 0/1] xfs/539: Ignore remount failures on v5 xfs
Date: Tue,  4 Mar 2025 13:48:15 +0000
Message-Id: <cover.1741094926.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test just checks for the deprecation dmesg
warnings when remounted with noattr2 and ikeep, and they appear even if the
remount fails. I wrote the patch because xfs/539 has started failing in one of
our fstests CI runs because RHEL 10 has started disabling xfs v4 support i.e,
CONFIG_XFS_SUPPORT_V4=n. The reason why it was not failing with CONFIG_XFS_SUPPORT_V4=y
is because remount was incorrectly succeeding - reason is explained in [2].

[v1] --> v2
 - Removed patch 2/3 and patch 3/3 for now,
 - For patch 1/3 - Ignore the mount failure instead of skipping noattr2.

[v1] https://lore.kernel.org/all/cover.1739363803.git.nirjhar.roy.lists@gmail.com/
[2] https://lore.kernel.org/all/Z65o6nWxT00MaUrW@dread.disaster.area/


Nirjhar Roy (IBM) (1):
  xfs/539: Ignore remount failures on v5 xfs

 tests/xfs/539 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--
2.34.1


