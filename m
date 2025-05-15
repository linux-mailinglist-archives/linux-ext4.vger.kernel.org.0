Return-Path: <linux-ext4+bounces-7907-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B28AB836C
	for <lists+linux-ext4@lfdr.de>; Thu, 15 May 2025 11:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C284188EA50
	for <lists+linux-ext4@lfdr.de>; Thu, 15 May 2025 09:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3CB297A47;
	Thu, 15 May 2025 09:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFeMu/ef"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D8A1AA795;
	Thu, 15 May 2025 09:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747303133; cv=none; b=XUR/7v5o4ONKl9zcWAQ1SbHcqYgnXPUABPjpwHcJ7VebbwiAt/bRsR7cPPp/9i66L8EaNQ2QAIcwLX+o+rOMB+sUdOe4xnqZyqMBRmUAYaaRQE1ev3wV8/XK7VBrql3AeTnV82Xcug0jviJYjbXh+2RRORrpd+UA8Zhn78M2nZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747303133; c=relaxed/simple;
	bh=+kNzFtXmyhwBtRKrJek3nlSxNARyqyuweSImX+0CSHw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Z0Conq9jLTVIMR+iH1fDAufLTxUh66bHHgaLzgSvttpAtu+j1FN3hhcapF5MlNPRb2GSRGcTCrVh2HYB/6ID6LPIo5+Gl1DR+FO6W5kl7JKF92xnUSaNa93zi7cZCczBlV39LN/NZ8u+DGmv+9u3dBrdoFLBKS5q3BslCzNg4gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFeMu/ef; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-e7b451b708aso565983276.3;
        Thu, 15 May 2025 02:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747303131; x=1747907931; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+kNzFtXmyhwBtRKrJek3nlSxNARyqyuweSImX+0CSHw=;
        b=gFeMu/efe0QHm5j4X9lP79Lmywofoe9338ckA4S8N/MArl0Qg9bTVpvw/Ra5Flkkau
         pUCHbw9v4cjRDaEeRwyPosHEpuVxpu1wFCrFzYZso6VU+Hc8HUE+eZSLylgz+jaLSJMU
         aOsGTykPVWoz0YsQ3KHRE4TaFZ/VC6FISWAzLaxTHlzH1mNCJwjhVQjXu24EcSpS6QUg
         UfkYQxsh0CuEN33HKA/PpqFoierD6B5rYGCZPebI5UEWXRtKzxmhvOMHuggWsuJadiuL
         0mYGDDMnziMTGWIHADA0yq31nXBuO4J7JETJ6m/mYBJoKnj+YpYsPCe+Y6xYzbYYHbbC
         HGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747303131; x=1747907931;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+kNzFtXmyhwBtRKrJek3nlSxNARyqyuweSImX+0CSHw=;
        b=etGcWCtebSR37lNPbmtEVir0aoXPDO2yyKIRBnIL9Im5jLYkQboDbjdD9zBXucYkX/
         Lplqj57/V3hEJ6paJs+yY6QeIi52psDf70dYQe+65wKJXTXT/tazVR5S92jCgjJKoKPS
         tTPo5yTr0KzNbs7RUHc4a/E3cvA83X6tL2deTJlWkM0YSr/iGKuR7VNFrn6aC6MK7IH9
         BtxPzSPB7Lk9sGw99NIvrLKmAC+NhJKXNFUHFZqtQYV+nl7hUYG0YcebkJqYs+TjB3nG
         UC8BNH7xd8ZKQVKwx1caiJaLP/JVUXP++o7YycfL7wXXSxPxKzMikixPQsoDxxspQknX
         207g==
X-Forwarded-Encrypted: i=1; AJvYcCU1aZzxRmORDsmuaak+07Ylxk7OQCnjAiyaMxjdm/Wgxw8Ch1M3ePMmRamXagrkSxqGqlrLIHMuGLtA@vger.kernel.org, AJvYcCUjWDufvoOlN9g2BjJ/R9bKXYUqk3uvSCTX0GGUgMMLNx6AIWl4MmHlgNNJKPYe6SVvM0S9aYYFXsq26PL0@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl+csEQ6HcNTNjh4FSN8VOZdL3iMDEtL9J0EYXqhkCt3cx2Zhd
	zjYyLu6zxqVgHBQAtpWtzPFvMDYGO8jG9TuTrYh/verzozgmHO2zqPtQQd8PLR2YyK221FzBSgF
	g3gASU8VDh6XH2/8ikTQu3gFbKm7meSRf2kxL4Q==
X-Gm-Gg: ASbGncvdZyshsIbIrVWxmVhKug8kGz/mwh8PURcgmqUmbRkAO+4JZx6XhFwx4jGV+L/
	VgClcBPagi+1RJR/+DZSF30CLXhkvvvSOBtVY7ks15T1T6wHVcQZb2gsV9+DCvPygh/1TzApohO
	EJ08tBMs64nVeVGNoAqNjeA6hZ4rw1ruckjrc=
X-Google-Smtp-Source: AGHT+IH9Kbdkxv7aRCrngn5BHmJriIYG/ux74zm2f+ZjXcrFEHBhBmDIwKscLZBDH+0CA++8CLV2C6Zl4PejX+3hEI4=
X-Received: by 2002:a05:6902:1813:b0:e7b:4b93:84d4 with SMTP id
 3f1490d57ef6-e7b4b9386d9mr4559069276.0.1747303131371; Thu, 15 May 2025
 02:58:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Guoyu Yin <y04609127@gmail.com>
Date: Thu, 15 May 2025 17:58:40 +0800
X-Gm-Features: AX0GCFvgkHunWw2E9wacpa_Iuhq6Dd-MCuH8i7nepAyQnEwlRqtBZgwZMiFyiyg
Message-ID: <CAJNGr6t6cpo3zjANpYObZaWOSeGKdGW4B4+k1Bh2ZWQZBbJrBg@mail.gmail.com>
Subject: [BUG] kernel BUG in ext4_mb_release_inode_pa
To: tytso@mit.edu
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I discovered a kernel crash described as "kernel BUG in
ext4_mb_release_inode_pa." This issue occurs in the EXT4 filesystem's
ext4_mb_release_inode_pa function (fs/ext4/mballoc.c:5339), where a
BUG() assertion fails due to a mismatch between the calculated free
block count free and the expected value pa->pa_free during
preallocated block release.

The call trace indicates that the crash happens when closing a file
via the close system call, with ext4_discard_preallocations invoking
ext4_mb_release_inode_pa. Preliminary analysis suggests this could be
caused by filesystem metadata corruption or unsynchronized concurrent
operations. I recommend reviewing the EXT4 preallocated block
management logic, especially in concurrent scenarios and metadata
consistency.

This can be reproduced on:

HEAD commit:

38fec10eb60d687e30c8c6b5420d86e8149f7557

report: https://pastebin.com/raw/DbusXrC3

console output : https://pastebin.com/raw/rjVjX2cb

kernel config : https://pastebin.com/raw/u0Efyj5P

C reproducer : https://pastebin.com/raw/iKzXm7Ut

