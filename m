Return-Path: <linux-ext4+bounces-10499-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7675BAC2A7
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Sep 2025 11:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D83C7A2FAD
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Sep 2025 09:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C959A2BE7D0;
	Tue, 30 Sep 2025 09:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfkIcLaJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2204F248881
	for <linux-ext4@vger.kernel.org>; Tue, 30 Sep 2025 09:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759222966; cv=none; b=RRJfysIhtDrnZatMe6bMIYPKOz6K0tT2tnZMP5ao7hGCWc5XIK5JZpUulrssU2NJGe2akzKzGwRC5Q9ZAjcGAT/CzhZIqVF1TgV1VvoBdGjM12Ep76j1WleIXemNbljXKcTkCignFJSKLdRLhm3s1VBw54IcJP2CoxLlhpPPMJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759222966; c=relaxed/simple;
	bh=xH8i/P0F5GMyOhXG67E/jf3pgWVIjy5A0p9ko23ALdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CUBg/vMVLRkA3v79jNsr1t4VVn+IvIRIkjN1ALDnDLyqRtkey9YAYgFs+VULpTEQ1BJ3i7YxKbkKv8EIio3qOO49ZsErvWNNSqZFrRAm4ya63lt/LZ8KCH54KLTkFu/Nig0WzNTp2A7rJeV2dflCAzatBkm9QooxQMVU2YyO+Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfkIcLaJ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so5013133b3a.1
        for <linux-ext4@vger.kernel.org>; Tue, 30 Sep 2025 02:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759222964; x=1759827764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RfeaF9FswrT4NLe5djmQ12Uk2hNy67gmHZ8YeclLXV4=;
        b=TfkIcLaJyg0h5hJXbCTodrNbQa6oTCT/HTtwDu7kR16jxHEIApbWX823s3by9AvqzZ
         tzD/cti6th2V5Y+wQ3uznjPlMN6eFpxHFUu+hZmkw/fTfM0bAA7YqWkFwmWfkQqAs8vu
         URkveoEMAXiT8Wil6hSQUaUB1EyVXODAPTtxinwGAz1ZbJvTjygyybz6craNM1LTv+L0
         sy6s082ByoIYe+kBW7YJmq2GS/j5N1wRqwwCPgYI6gnUUiNMjD1Kwhs0XfdfX9pY2rAi
         LKgOt3AwtPwuKMaBq5GpLZi/BS8DgFFahh14CpdDlwa6wBKIMJCQuHhgdFnU5tQaum7t
         9ZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759222964; x=1759827764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RfeaF9FswrT4NLe5djmQ12Uk2hNy67gmHZ8YeclLXV4=;
        b=qg01ck++JjmTVchy6uXEShuTDPP85D1FtYVwNJTNwMCBy4tQuv7wazKcifZFjOAPtY
         x5Yx/vtOr1oVdRtV2UQ5IJ5GZ+ekh/A1oIUGnCakM0xgH7QQN8lu7VXWlTs0ihMiW/GA
         vn382gIYfIcKogH69h1uzpNCwFzAz/520IITIj7AHyaoVCZrlFAYUEynUhR89k3gsnX4
         mp5jUUVahnYvpO5Lq473Pj0nhpAwubga559x8VGWAr2FAHLzZ11wsCNzF7U/Qj6eIE+H
         //v3qexiRENHDNUo4HsZJARC73Oixgw771/jWx1hCMvVUBz4FynqqBEaxx7ZL9QI1kdh
         DqgQ==
X-Gm-Message-State: AOJu0Yy8MMD8nDiQYGS1rBgAzoPoBLUPlWbf4Svnj4dd3zoJulu150j8
	oKE2Dv7JqR5y6lSYjBBNTJJ71QjMPgAD03F3LtAKA5BkYzh+PQ9u83ab
X-Gm-Gg: ASbGnct1VfllcVC82kHdsm7RwncPG1R33rbjOcbIdp+dfyQTw7GSmFEvzLpGhgMnHhP
	9bXrYmzbKFDBkJxMvpIMqpXz8FISrj9iOd60VDMXIx1eCHWyJOxg3Npsiz1M6lCbmgJTaX/AHox
	77XyseG56MF9rgs5HFK1kXYnfmHDoA/wQL9egJnyDknVPAPuHdPsfTZD2Fk9GysCazWqwWquyOS
	RgmrA4CemVopnuH4wnl2lwcYcH4S1lpYE5bBFHHtfT4MqMPX1Rcfc3ckp5c6Ro7D1c9/smEHLiu
	0s1XbDo5OUdZaEnQl7rQ2YnftUV9KS75tVtxEUM3UbhGlrqLfcLhTeLwzhYYSLCd57O5HfqTKBN
	nE9S+yz7zBk6pB8YCGUDfusvuMhZHPZT3gA00ZFRJteQzwtFDTomhlN0DwZR6SazYOOKj1lyi20
	5uTGmviQcoTPs7n7MSa9QrVvdWdk4=
X-Google-Smtp-Source: AGHT+IFd5eZhiu9Zd++0fFXkMaMCe1sb8fKeTrMPHQa68TU2FlUs5KWRM1gnHv548WvGqki6zxCoZA==
X-Received: by 2002:a17:903:19cc:b0:279:373b:407f with SMTP id d9443c01a7336-28d16d72a20mr45272355ad.5.1759222964145;
        Tue, 30 Sep 2025 02:02:44 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:a158:2d96:7596:9c93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d3acfsm154851715ad.20.2025.09.30.02.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 02:02:43 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	yi.zhang@huaweicloud.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ext4: detect invalid INLINE_DATA + EXTENTS flag combination
Date: Tue, 30 Sep 2025 14:32:37 +0530
Message-ID: <20250930090237.306607-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Zhang Yi,

Thank you for the review. Regarding the placement after ext4_set_inode_flags() - 
this would be too early. My debug shows that i_inline_off changes during inode 
initialization:

    After ext4_set_inode_flags(): flag=1, i_inline_off=0, has_inline=0
    Before my patch validation check: flag=1, i_inline_off=164, has_inline=1

At the earlier point, ext4_has_inline_data() returns false, so we wouldn't catch 
the corruption. The check needs to be after all inode fields are initialized.

I'll fix the alignment and use function/line variables as you suggested, but keep 
the check after "ret = 0;" where all inode fields are populated.

I'll send v3 with these fixes shortly.

Best regards,
Deepanshu

