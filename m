Return-Path: <linux-ext4+bounces-8030-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5138ABCE6F
	for <lists+linux-ext4@lfdr.de>; Tue, 20 May 2025 07:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64DE6176F33
	for <lists+linux-ext4@lfdr.de>; Tue, 20 May 2025 05:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731BA25A2D1;
	Tue, 20 May 2025 05:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UU0tk+0i"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC1C37160;
	Tue, 20 May 2025 05:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747717944; cv=none; b=gyFEp6nQAjtFHlJHlztAArI+ASnFwOCmUc5DhDtq/60KerQnlgM3U7PISwAB254RSGHy1/oczl35Kove2L8h9jIbZRnXI+vRajT7aUzgT0zF6JMslKCpIwteCD3aXN77ZEGky+3Oe068BRh38FRvN5ornjg4KtH4TH/1sPIyZMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747717944; c=relaxed/simple;
	bh=GHoztvyicimc75aqk2dRs2MZoLtuod6o/adKnEpwsrs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Jd1YoXINEFXxX7B/B2U2NPO6tM9WWet8A1YBiuxdZ1S5QJ3XHWeShIwbFLXLWpVnNR4BqmMLKnIPYXbbqErquAG62FUxX9D9DmEy4iD/F4TuM0FosyfThjFMY8YSKEMbk6WPJkNrmjucpwGHJbCx7xJ6nAhsEXDnk+nZPGle3ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UU0tk+0i; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-e7311e66a8eso4549027276.2;
        Mon, 19 May 2025 22:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747717941; x=1748322741; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GHoztvyicimc75aqk2dRs2MZoLtuod6o/adKnEpwsrs=;
        b=UU0tk+0i1wmEd23Wj5mVen1WyrzX7dcpyeqtbw0kx0xWmuCuaF6rryZLbOHi3F1tgk
         2q67GKnMMX5pezvsGIK/N5Cx9y/dGmxJjKGDrJJ8o8dDxsl4xGNJEDMokMnFv0cAyGqu
         UpYy/yUQyKsBwMODJ/wohKUjZQk4ZOZn9xtdVReuAF/86oykbQ40Civ9dbGJJEU141xS
         WN0zr2ChyDcSznMaWEzj3qQXNtofN5PIudOeJnKcT6A8iM+W2iiWQZ9sE2IXFD3b2cAa
         3PpqL90hS5F5swAgW1N47pUbEYwY6CfLZGXdVtb0jv89G52RrV7qDX4FEOTK1mZFpxa6
         FLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747717941; x=1748322741;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GHoztvyicimc75aqk2dRs2MZoLtuod6o/adKnEpwsrs=;
        b=cxXs+3il8/N/itGvE7SjREoGZ7puxuLoWIBkQ/fLNaP/SOb6xzPPR+yoOTYtZu+wdE
         7PhUbbV1C3GO2i7FQDRR42PI2eG2WNABkhX53mQdQZsJW6WTPb8kjsBGpNRCjt+rCA2e
         TOVKiSApOMXmXGz7RntfWx/ohGJiteEzrwkzURZOTnLRt8rCeRBcMJGxak/yVPEHKUNA
         7SD3Tsq3zvZhy6ZyhT1Cg6iNVXpTsoWvCYGKJG55a57C0oauwIU847QPbqAx1nTlLrIK
         J6zrzstQmGSXbHr3ZSzsJDBJCcritNcfns3S/loSQHm3bIXZW7nJIuLK30mQSjVOOA5R
         h2uQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKup/7oCskVnCEaRBeQdFZ/M/4NKp0OsZ4+5Kldfl4GJ6gh2OjILqw09pCXB72C1xW2itrzXbDex9/@vger.kernel.org, AJvYcCWMkc0MEByIakxkpzWI13lLHgOuutSTV9vzBRzl/sZYQB1MTyCaFt5jy9F3+RvVMinse9SLFUuH7tAkedFe@vger.kernel.org
X-Gm-Message-State: AOJu0YyyMffenxtyNAR+SWr9twzbn6fGLFxR4b2Ou3+7+Y6jjHvY06sQ
	nL/BVZFOazA1pMuKj5UAg1F4Q6RueUf24m55ezr+mPI1Y4zRypZEOqWNgD1DjZdt7enNwwZH7EJ
	LllTiNwuIitN+xs7swsugzYe9ofAAFY3KOlyFiVk=
X-Gm-Gg: ASbGncuQKycif2SnG3LpPrYH8YTnK2oAUzmou2EcVgI0QEowqnRFf+eOqPa2tmrxyQK
	UDnvxd0AkOG/6zfzkbCdygiCY26cR5jLeWTqs3zbHweWgPWzhU7MovKThX/0yIl04byEPhQKHua
	GBHAFt9059VyJxVx6dABTsHYRhe7UkJ0n/LQ==
X-Google-Smtp-Source: AGHT+IE5gYQRhcbealjT4YAqD8a8zhS+tg1zwqpkPjrukIoCzC4+bJq4oYDQlDu6uc905meoauiRCQe5XBHSNRDB7w8=
X-Received: by 2002:a05:6902:a0a:b0:e7b:8422:873a with SMTP id
 3f1490d57ef6-e7b842288e0mr17553203276.5.1747717941596; Mon, 19 May 2025
 22:12:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Guoyu Yin <y04609127@gmail.com>
Date: Tue, 20 May 2025 13:12:11 +0800
X-Gm-Features: AX0GCFsyh2MREW7tlUxebeXhhrXSQAP1BeeKS7TOK9X5uyXoQhF_BQpkfbj1ZVI
Message-ID: <CAJNGr6v57z_RR5fNV+tLuGXEVKLRfXdo+hNS81HzztaC7pgchA@mail.gmail.com>
Subject: [BUG] WARNING in mb_avg_fragment_size_order
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

This crash can be triggered by repeatedly performing specific file
operations, causing a kernel warning in the Ext4 multi-block allocator
(mballoc) module. The issue arises in mb_avg_fragment_size_order due
to an invalid len parameter leading to an out-of-bound order, thus
triggering the WARNING.

Root Cause:
1. Code Path: In ext4_mb_choose_next_group_best_avail(),
ac_g_ex.fe_len might be incorrectly calculated as an excessively large
value (e.g., via roundup).
2. Invalid Parameter: When ac_g_ex.fe_len is too large, order =
fls(len) - 2 in mb_avg_fragment_size_order() exceeds
MB_NUM_ORDERS(sb), triggering WARN_ON_ONCE(order > MB_NUM_ORDERS(sb)).

Code Locations:
fs/ext4/mballoc.c:834.

Proposed Fix:
1. Add validity checks for ac_g_ex.fe_len in
ext4_mb_choose_next_group_best_avail() to ensure it does not exceed 1
<< (MB_NUM_ORDERS(sb) + 2).
2. Enforce strict input validation for len in
mb_avg_fragment_size_order() to reject invalid values.

This can be reproduced on:
HEAD commit:

fac04efc5c793dccbd07e2d59af9f90b7fc0dca4

report: https://pastebin.com/raw/W5ejqsNx

console output : https://pastebin.com/raw/U9qUGBhY

kernel config: https://pastebin.com/raw/zrj9jd1V

C reproducer : https://pastebin.com/raw/TCwWzfaH

Best regards,
Guoyu

