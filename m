Return-Path: <linux-ext4+bounces-7790-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 695C8AB0B4B
	for <lists+linux-ext4@lfdr.de>; Fri,  9 May 2025 09:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A930E3AF4E5
	for <lists+linux-ext4@lfdr.de>; Fri,  9 May 2025 07:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C665126B2DF;
	Fri,  9 May 2025 07:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0zro9vk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4CE26D4C4
	for <linux-ext4@vger.kernel.org>; Fri,  9 May 2025 07:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746774679; cv=none; b=jeKI5kLV1kafZ1QI3t9OBpT955HLVm+39I/icXcg7BdqV1b1PcNyOoWfTc6PZyrHfZ6jAWTHJ24kKx/lELjBi0Ic/ALZJ2sMJOX7BKfIRlvi7FW+V/impkMNbwQ7Og3qLWn/w91eT5CEEaJ+fLpsGZWvBNlt6Bbh3EhC1g20jAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746774679; c=relaxed/simple;
	bh=zG/7gQlj0kjyAgJcpFEhmHu0qP3z3w0rHHkQ5oLLh8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dVPcHKJBsYnYW+wRzc0WjUpaVDhof2q/0QET9RbVca3yL7t4SqQPjrU4QuC1KseOfOfyc9UqZWVZLo6poOWzN7Ft2JuZkuDSf/s/TAFswxpZ4Y+8x+tT4iAIIRYTOa3v0rsslFyZ2Gky5HZ/DM4f75EHVkT91EtT3MWZoFBh0Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S0zro9vk; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7398d65476eso1584759b3a.1
        for <linux-ext4@vger.kernel.org>; Fri, 09 May 2025 00:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746774676; x=1747379476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zG/7gQlj0kjyAgJcpFEhmHu0qP3z3w0rHHkQ5oLLh8E=;
        b=S0zro9vkDTVpdPtdJzbFLECScudh3bA67HJ1OEP0Kikf4mPS6p1SODFBJzt2E8z/Al
         MhlAbbXHhTuA0a4J+7KH/JRrLx0u43M9RSA2jHIn1ss8t8e9qzVFuGj5pjqYpwEtxtOl
         V3+WKuQEE2hREH4Cad/mjoL9yaUOaxlMuXdvofhDSDTfK1IicAgjEGaRif/HSIWqpVaB
         d0eV6dE/x8v2/fZSFOdCiH3yA+uHKukhQVMDG50WY97mfnwTWrzyNjMNngopgyHQhMXZ
         56Qn24J6BKEsY6wNtGLM5d1GjI/+es9ACSVMlW+nk9Yv4qSs1RELeHM02zB3/tMw7rPD
         /yRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746774676; x=1747379476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zG/7gQlj0kjyAgJcpFEhmHu0qP3z3w0rHHkQ5oLLh8E=;
        b=glDoal7aowX4by7xnwoRREJXLMcTva0zF8NJROYYX9rBTQMDUSzdo1POERRhqGgc7T
         0yt+3i6/vd++AnaaEqAFYlNNImlheUtiBAGJDws1a/6Rsf2j042rANo4H181WZtECiNm
         2jdMKqF2kx8eC1LsZnrjm3NuqDiqnchvDOE35sDCKg09XlBLwQfU1ybRe4NCEWs0RY+p
         qoCGlh9cJPw0OAqhU4UdaQQhTzImGYhT1jGdY76d67aCljCK18D7iwfFtCtnTDnQ2Bzc
         Kx4covSy0fFlZWvYTpdLG0cNtU0t/6NZYELbN+o9hFiSfDt5ZtNA4wFyNHMbhFtqF1I5
         sHxg==
X-Forwarded-Encrypted: i=1; AJvYcCWsyoem2WroENPNASd6CcATayEIn8dbahGx5Rr6VnC5xb3pwOVMnJgKxr49Wmvx62238fFRsPOPyPN4@vger.kernel.org
X-Gm-Message-State: AOJu0YzeadvnzihpDgyUqz7LOpp2cqwmwBCv1H82dD2eaeB+gEcHoyyP
	2ViH9HWRD8J/o3hRmXdoTAVfUL7ZruPVamtrWfiys2XB3ZxQPSMS
X-Gm-Gg: ASbGnctCHAITMFCiy+XDpDdIpAljvvF+DxKwqnrRe426p42/i+b/p4AgVuEbVQVSncv
	DKU+khwXT8k5SMlSZ2G6j5jHSjb0CnKHJt1m5Ah8f8Qve+bJeDYLkcLKX83C95Pgo3HWbmYMSwy
	y9iKkqt9JrOk/Z7FCaMAluKTguZGW/AHhInBuT390fiJbWPpTC0Q35072fV3AQxCPpOKu4ICGea
	rjSST6ut3xD5FuMSMiKfFwSTxx/izT9RwWkxB87R18rU/f3h4dypnhoS2ScCoahMLKLfvWZlIW5
	8qhFkJ13IGRddizwQmTnEskQW0WGFXVsZkdA9lrlw8QXnMvP98a3q5JyXwJN+reY6gwHqbk=
X-Google-Smtp-Source: AGHT+IHY6xDad8AYeOlr4pS1YNtzlTxtKEQVmMM89Q4oLxnbFgNgf3WiGWy78xDDRumuIjzPiN1TgQ==
X-Received: by 2002:a05:6a00:9286:b0:736:3ea8:4813 with SMTP id d2e1a72fcca58-7423bc1d4d7mr3246176b3a.2.1746774676090;
        Fri, 09 May 2025 00:11:16 -0700 (PDT)
Received: from vaxr-ASUSPRO-D840MB-M840MB.. ([2001:288:7001:2703:b136:43ca:5f8d:1736])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742377278cesm1185423b3a.50.2025.05.09.00.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 00:11:15 -0700 (PDT)
From: I Hsin Cheng <richard120310@gmail.com>
To: syzbot+d1da16f03614058fdc48@syzkaller.appspotmail.com
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	I Hsin Cheng <richard120310@gmail.com>
Subject: Re: [syzbot] kernel BUG in ext4_do_writepages
Date: Fri,  9 May 2025 15:11:06 +0800
Message-ID: <20250509071106.383057-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000006fd14305f00bdc84@google.com>
References: <0000000000006fd14305f00bdc84@google.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I've been looking into the problem so far, may I ask why
EXT4_STATE_MAY_INLINE_DATA isn't supposed to be set when
the inode has inline data ?

In context such as ext4_conver_inline_data(), the code there
implies it is possible for an inode to have both EXT4_INODE_INLINE_DATA
set and EXT4_STATE_MAY_INLINE_DATA set isn't it ? or my understanding
is wrong, please correct me, I woud love to learn.

Best regards,
I Hsin Cheng.


