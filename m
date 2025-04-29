Return-Path: <linux-ext4+bounces-7526-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF64AA03C4
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Apr 2025 08:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66D901A81FAB
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Apr 2025 06:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0602750FE;
	Tue, 29 Apr 2025 06:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naJv4z5E"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B751E515;
	Tue, 29 Apr 2025 06:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745909597; cv=none; b=e5wl9KfFtl9LNr1bSUGHzYte6o4Nnr3QwDIe53eoMO+Bu0I6M9/h3u9tvtulCCRP9F1gjC1xdo12YKcDs0RVbuH3C7m12//5VVMNofJwkc0Ifx/iJTNmJ4xl9iMeufCN3o5bfmcbIQDDVp6Hd0IP8RlEuVsDUtQr6F/kGtYY6po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745909597; c=relaxed/simple;
	bh=H0DxWQxT/vt6vtTmMMkLS4orhiBpJnW0Wwz/Aaj2jJY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L/T0UsetEPY9ZXtVSi07awx5YmX2HxnH7mqA6pLhogOZEmkG3X2dsyKDA5GG+E8jRjJkLzA63+T2qO7qOOTh5JbshFc1x2suwy25d0p4RZLTx7+SapMH1qOvdQ2FUlb2CyzbiGRQsJHrVuMvBHKX8HfA0VuAQ0BHN+Zrin2vKRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=naJv4z5E; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-224341bbc1dso60265605ad.3;
        Mon, 28 Apr 2025 23:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745909594; x=1746514394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PWytkNwNq3JbjY0CzfguN3i2miVxpmHE2yuThu/jf84=;
        b=naJv4z5ECL4CKFfzuDp08xaOlwcz5LzS6h+m/tR5M8UY1nAJnGgIquVm7G1n4R+8yH
         JCIlR+nGjGel31zCwNQ/jfeoJBFiTwayoeQpVPGvL7H9C2uEcXqaXfPZYIRsPdJ3KW6M
         rZKl4RepNpSzw3mneCgswpK4qQxlBqXpiBBotDjDyqBUPCR1fo3Guli7luEm1NRxG2ii
         E+0L1tfSh0ps0//2mQc0Mq5BlygLh5E4IZUVBGNAaBuhQFml8fhUYqec7CEMFsMbn5Gt
         rBdNzctxGpTKiWBwlGjyy4Zg6/DzA6B6IXr09NE/CWazJMMjy6BiSH87l4n6f/JmePwr
         6f1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745909594; x=1746514394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PWytkNwNq3JbjY0CzfguN3i2miVxpmHE2yuThu/jf84=;
        b=tO2UgGssjnDdfmfC/RsnvBd6WR1lr4EhZssuHrQON80lNTUxc9gctRXJ6r1gHnn4Wu
         /a/vz+VddUParSP1WsMoAgrzLwAqck7tUa7zNeA97b6x/hgV/R6Snn4cqnXK2Ketax44
         QMxkSG8M+DDM4pf+fqH0cdQeLMZu8hGEPVuxSXgcTYQx6wiD3325LtpuaPtdUROPHMtz
         DOGXMBNZTPkAbMVStgxN2nQS+kphwrVn3twxOh5gzrJcCXsG6q5LZFS0YjeBbLcVRe52
         P1x8Tl10Dlzjmuvd0ONoHeiQIWZwvoSnHtKuZ+JIMCXnkLHB6yF8uoj3oGPW5hoT9tMP
         nvZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWC7H7dDMvjYP9/yJbF+xYkmWbuTsWEE+BlZom65WfK7dZuojTN5+LpbTHcMY6Hm2OOW7DUagugyVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcfEap83+B+kl8xjVqG7zscqC0eNEJWjxSEmYWqCL1JwvJfvKM
	5BPku/+A/b8iWG/BcBBhAyX3LddKG1VksEwelpdveDsNVAiaqbaSKW4jJw==
X-Gm-Gg: ASbGnctMMYquOtD5NnjekbW2uT84mVq485vO9CKyz5rop0/7emqzST2FcdWsGgmK8qG
	iiUycxGF+dFwEEMoo/WHFW3c6Y7PmCDz20obOVOZ1SbGUD+x3F9gEnnBYmQ/PoLbQEhELv86Ohm
	RBZj0HFA2Os0rMYGJpujPwTlVhQQ4rBr6dyTqAAa7fe5PV9oI7NWjz41cb9g8OaoCbhIgB3vkTr
	aL3H1eGb+oP4JsEQb1J/Jcmg3S6//WUK7Dl5jhntrRB4pUVKAcP75Tt+B1IyS5h0okmQLxvr8q9
	SbDmwkiPhOaK2qplPWCzeQ/fRpy/bwiL1a2MqERlgGVo
X-Google-Smtp-Source: AGHT+IE5/Q1OZ08KMNBNop+c4JGIRcQl4Da8KTZnPr6fDqtmFjDF67AMcykFCJvEcqdubEj37lslfA==
X-Received: by 2002:a17:902:d4c3:b0:220:e156:63e0 with SMTP id d9443c01a7336-22de7009e81mr24101555ad.8.1745909593699;
        Mon, 28 Apr 2025 23:53:13 -0700 (PDT)
Received: from citest-1.. ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ddf3c9d1dsm24149805ad.244.2025.04.28.23.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 23:53:13 -0700 (PDT)
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
Subject: [PATCH v2 0/2] common: Move exit related functions to common/exit
Date: Tue, 29 Apr 2025 06:52:52 +0000
Message-Id: <cover.1745908976.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series moves all the exit related functions to a separate file -
common/exit. This will remove the dependency to source non-related files to use
these exit related functions. Thanks to Dave for suggesting this[1]. The second
patch replaces exit with _exit in check file - I missed replacing them in [2].

[v1] -> v2
 - Removed redundant sourcing of common/exit from common/{btrfs,ceph,dump,ext4,populate,punch,rc,repair,xfs}. Thanks to Zorro for pointing this out.
 - Moved the sourcing of common/exit in common/preamble from the beginning of the file to inside the function _begin_fstest()
 - Moved the sourcing of common/exit in check script from the patch 1 to patch 2 since patch 2 uses _exit().
 - Replaced exit() with _exit in the trap handler registration in the check script. Thanks to Zorro for pointing this out.

[v1] https://lore.kernel.org/all/cover.1745390030.git.nirjhar.roy.lists@gmail.com/
[1] https://lore.kernel.org/all/Z_UJ7XcpmtkPRhTr@dread.disaster.area/
[2] https://lore.kernel.org/all/48dacdf636be19ae8bff66cc3852d27e28030613.1744181682.git.nirjhar.roy.lists@gmail.com/

Nirjhar Roy (IBM) (2):
  common: Move exit related functions to a common/exit
  check: Replace exit with _exit in check

 check           | 44 ++++++++++++++++++-------------------------
 common/config   | 17 +----------------
 common/exit     | 50 +++++++++++++++++++++++++++++++++++++++++++++++++
 common/preamble |  1 +
 common/punch    |  5 -----
 common/rc       | 28 ---------------------------
 6 files changed, 70 insertions(+), 75 deletions(-)
 create mode 100644 common/exit

--
2.34.1


