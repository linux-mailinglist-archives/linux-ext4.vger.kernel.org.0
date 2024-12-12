Return-Path: <linux-ext4+bounces-5597-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 852AB9EFAE4
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Dec 2024 19:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFD6B188752E
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Dec 2024 18:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F09222D45;
	Thu, 12 Dec 2024 18:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qg0hTqLi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842D61547F5;
	Thu, 12 Dec 2024 18:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734028138; cv=none; b=Yy+16BclE3p6jcJ5123wSdxJzazbnSA8c0A3rMEp3BNlFUf83cBZo3G58vDj0MQuz4x7oqkb6fPN2vDGGfeUzbh8v4cCqmkL6xCQDPu5GmO77nig5+TGtLtV/Yx90mBpEqZH1bB/SRpBWBuNT8qxpPEtqKvnHLA/0XVzTnrrROk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734028138; c=relaxed/simple;
	bh=KuZi5uOGUo7WkDSMczDqEF1ggsJGATM0BMmMUjUwwyw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Koot2d2Ot3q9BOGCM6/PrFNQhZ+VBpsuOTquvlNQS+tfY+NytkHhM1MiuwZ2Y+tyeLDWu/kkgetvU6FiWP+F7r8Tx7Z+fBDeMM1CbytmVtQEGRICy21CTHjH7/revyGPKv+wO+LfDK91+h2Pvs73FgcxaJqBh01FsOQeTlR6SFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qg0hTqLi; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso831357a12.2;
        Thu, 12 Dec 2024 10:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734028136; x=1734632936; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KuZi5uOGUo7WkDSMczDqEF1ggsJGATM0BMmMUjUwwyw=;
        b=Qg0hTqLikHDkGbbg40BmICGkWYsidcdxvwrruUb9hCpT1w5IwTzzPJNZlYeWGxOs64
         wSm3D+WZZdgpl8dNxhNG/MNtjficSRrYNorebzx2qxSfGePFYIHV1ojylzf9FAi97bu1
         BsYJFSQ2A/ikXasm95CX47css0TO3gmlXRrrs8Os/+MmQ0tIx3/1xvK0EHqnYbiYadj5
         f4Tg9KOI3z8Dv5qIaN2eSEsv2jcvEXXutnc5s8kC6haiMgetqpx8BfRTV0PBcmDvsdaE
         lhjHFO7BlovVRf8ZinJ0Cn+dclSeOjrvi4+KgNxFxsMS5wMwfsM8mUFQC1/nAKJwklau
         oeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734028136; x=1734632936;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KuZi5uOGUo7WkDSMczDqEF1ggsJGATM0BMmMUjUwwyw=;
        b=ELI62oFwy2vHGipX97tdr/bCnxpX677if7OzwWspAH0P01yYiKP8fbbzAlN2Z//YPv
         l6e6v3g27gstMOyzwUAkk+EHbnCR+G0fcg8DVi5gvEl8lTLW4unJQDJpmZLp5GMmE+Az
         tDFlzUPGMmPE8bja61K2s9jpiJhlUMQit4lLM+mw9xwesu++Fek2KXqJaR7OON3r1r13
         BRe0K2b1bMp7aXqH41MBhf7lY4Gu1NoSvgCoT512n9V332iKaAdFjt0g+rZ4H9FZ1y+7
         ORvROMRD5mlG7JRm8PKNOCiXyGZyorNTDlyYyvEfsZWWc35cYne5/xUNRmHlcwV+uUpn
         ZRzw==
X-Forwarded-Encrypted: i=1; AJvYcCUFsX5Ov2RGwbPTFof5DLeAqjHByHOfPsaXHXh3T2YvnoW7i+cV6+kgpVyAQq3cMmUQ8WtqYYOjaqOel1M=@vger.kernel.org, AJvYcCXtZvxcghyk8a659WLLFmNlUK37kEPjg9fWYFLYCQvwuod4lRSoX/4z5o0NVEyZ55kx4pKEuXkG@vger.kernel.org
X-Gm-Message-State: AOJu0YzLzCeLfD9L1Q/oCPMahY0R+BI7B1jHRcwTiL9Umkd4rWZP/GLE
	UxvdAcdo4o4wNEAANUO7u6G1QUciFZE53XvHKGBQeAb1R1p3QvHmXDETaKvdz+wuEFkeWG7nE0B
	BpvBCUfBugnfK+LQo6FThUUnScI7yt5c41GPQSg==
X-Gm-Gg: ASbGncvJyewo1oTjwYVvTEWYVN0kVkOqEJh/SMTSnwE+At3+DM8QvLNV1utryaaqBek
	Kq26//HmAW0Wbpjm4niSt8+yX+so7unDZDMVsEQ==
X-Google-Smtp-Source: AGHT+IEZvkWt55ItNFxmCGiDc0Fwp4AOUwVuF9GHmlJwzHDmGUHGrK9VebUoiZtmrbAvKaxJmI6WdL+rbTHn0Lq69cI=
X-Received: by 2002:a17:90b:4ace:b0:2ea:498d:809f with SMTP id
 98e67ed59e1d1-2f12802cf23mr10521820a91.26.1734028136317; Thu, 12 Dec 2024
 10:28:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nikolai Zhubr <zhubr.2@gmail.com>
Date: Thu, 12 Dec 2024 21:31:05 +0300
Message-ID: <CALQo8TpjoV8JtuYDH_nBU5i4e-iuCQ1-NORAE8uobpDD_yYBTA@mail.gmail.com>
Subject: ext4 damage suspected in between 5.15.167 - 5.15.170
To: linux-ext4@vger.kernel.org, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jack@suse.cz, Nikolai Zhubr <zhubr.2@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

This is to report that after jumping from generic kernel 5.15.167 to
5.15.170 I apparently observe ext4 damage.

After some few days of regular daily use of 5.15.170, one morning my
ext4 partition refused to mount complaining about corrupted system
area (-117).
There were no unusual events preceding this. The device in question is
a laptop with healthy battery, also connected to AC permanently.
The laptop is privately owned by me, in daily use at home, so I am
100% aware of everything happening with it.
The filesystem in question lives on md raid1 with very assymmetric
members (ssd+hdd) so one would not possibly expect that in the event
of emergency cpu halt or some other abnormal stop while filesystem was
actively writing data, raid members could stay in perfect sync.
After the incident, I've run raid1 check multiple times and run
memtest multiple times from different boot media and certainly
consulted startctl.
Nothing. No issues whatsoever except for this spontaneous ext4 damage.

Looking at git log for ext4 changes between 5.15.167 and 5.15.170
shows a few commits. All landed in 5.15.168.
Interestingly, one of them is a comeback of the (in)famous
91562895f803 "properly sync file size update after O_SYNC ..." which
caused some blowup 1 year ago due to "subtle interaction".
I've no idea if 91562895f803 is related to damage this time or not,
but most definitely it looks like some problem was introduced between
5.15.167 and 5.15.170 anyway.
And because there are apparently 0 commits to ext4 in 5.15 since
5.15.168 at the moment, I thought I'd report.

Please CC me if you want me to see your reply and/or need more info
(I'm not subscribed to the normal flow).


Take care,

Nick

