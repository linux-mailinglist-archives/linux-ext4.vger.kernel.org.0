Return-Path: <linux-ext4+bounces-3487-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFEE693E198
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Jul 2024 02:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 875C41F2179E
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Jul 2024 00:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E14184D;
	Sun, 28 Jul 2024 00:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.at header.i=stefan.tauner@gmx.at header.b="ZTwY8TQA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8789AEBE;
	Sun, 28 Jul 2024 00:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722126895; cv=none; b=lEXHFGrtfvq9Ogp1NbQMudAcitmU/LvP9ilGlpVTNO4vg7ahFB5wwrPX6yqUit/1leGeC2iwnXoM//NG8g3LGyh+lQoF3WNsfjy3ymCXDSShGbe8lEYfm+geWk8Pbv7ebMgDzRo6KaK2aryt1vZ7FistjGfeauGycUxoHY4Sdz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722126895; c=relaxed/simple;
	bh=DdovRfaQ0ddc1R3sEJCeuqd30uDFrHQkQKeo7Cbhv+w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NVemcHUHjIyj1/ISkndj9WBCiymec1etQV+y8x7pbViqBWpp48QAYm0F5GvktRd/uiED/KZPmUn9fbseowj/Uc/xqmvCFr2OFZTJbYgco/vLWefKml05ePBLzOL9Gy987Vmeqmjgf9N6O/fZIwXZFs4MexcWMZvzrgF3crvlu9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.at; spf=pass smtp.mailfrom=gmx.at; dkim=pass (2048-bit key) header.d=gmx.at header.i=stefan.tauner@gmx.at header.b=ZTwY8TQA; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.at
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.at;
	s=s31663417; t=1722126886; x=1722731686; i=stefan.tauner@gmx.at;
	bh=2nvUqJi7GyZslLuPcalaiKWicJEZZUjv1ZsbS5Mhy4E=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZTwY8TQAtWADB21nYWrSrFLP6zbCDjoitACqPaqh7K8fIJDQ2VF83HLVIhgIe2zB
	 lPzkv9SWrXhFyFE3DeGvtGHP2pfQub26uTJIgPy9OJ9qBZ7hfBP/gnDvkWpNKIx47
	 gMFgWfWlDu9f6md+GWW/cwXZDdkIaiF2MU7DgcJ6RFO43ta+AsDLECFUqgxibh9Zc
	 ALQSZdffIXb22VgL8/tfrbLuJR7GAhHEZKUaQ/QccAqxfhxkKw7F6dyeAo1mEhz2C
	 RHgMnBqxSE39cYXn0akzBB8mHG+YC0cbVahrWcuZWWEDG2gv4kLpSsO0l2y5GBuZv
	 +pkyFBbAvAwRV9A7pA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from legacy.local ([62.178.215.48]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtwZ4-1sHJWc2yrM-00w9vh; Sun, 28
 Jul 2024 02:34:46 +0200
From: Stefan Tauner <stefan.tauner@gmx.at>
To: corbet@lwn.net
Cc: linux-doc@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	Stefan Tauner <stefan.tauner@gmx.at>
Subject: [PATCH] Documentation: ext4.rst: Remove obsolete descriptions of noacl/nouser_xattr options
Date: Sun, 28 Jul 2024 02:34:33 +0200
Message-Id: <20240728003433.2566649-1-stefan.tauner@gmx.at>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uua7W2IiMThMLS/lV3jpybwQiMIjOljUmv9Cd8QbIq6xP6Y/6sk
 OiKB5MrXn/CXyKuc5IXAICs0jpjVNAp+VGcOKJnAKwDzQe79jdCN2soELDhVrOmzeY1pQv9
 5IOwnRmxZjUPf179rTt/4p1eBmKH9PlgZ4rlNZuMVpaiHYkb0u+47xC/OOyq8jDlb+d/Irt
 R5Ey8f1Wf9EZpBv/qYlpg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:o1a/GDKdUzc=;osAfTKDsDG1Cmg3ts/jPb6eXC8C
 XctfewN9oBdYD5KBf9NtSUXIqIQWKyCXS/N2nvRwYonW9LLi4aR5EBpV+F22ETdKPIdXaFyQS
 PHFvvM91PBEBYJXIu7kM74PCgS70yMQoej1ZOI3AWdOqdI6aVsFSuSqG3coHheeEy9x7+P6ct
 iYppEzBgTvsRABeaAWpFg/vA7Ijfahf7zLqlFfbvLn3p1nnkp/IkB/lFcKvQPedh02yQfbDyd
 NfELYqfcaFJ+3AStXbiNVIx+d5FpdpcenNhYwfKabAK0Rtc/U4RUWJ/cRk7FIY3VwzCppOInq
 9eTen0TmtS6x1RPp+4K0KDEFKw+KETksAJ8zmFod84b6p8a+QY92PqnaR394tBNKXlF4z3KMP
 v+xJymCU/lzbGq4wESyw2ihTT9ZxzSUkjjITvsLsrbbFkFE8orVmrLXVRJNR2RIP7By9uWGse
 oqG8aEiPoI+CwNuyZWu+Dy7b/Byz59ld3WdtW876iKUb9KIYLkXGHp0JGX8imnJdtnWlBUMjR
 cQxXQinvlfRoXVrx/oXGa+HanR7zQ5GqUNIOpAYMqPI8TxloE3VWoQa3piiH0kHvkdmIyJ0WS
 sytTyOwergsxtiv9tQhZ0wX+uiXAeBKdrbDaFOgpM9NNe7jp95FHLYBcooLL4ASti4I9IDsWp
 vHzDfNvkr5o5HPi3K+fKQxou2Mh7ADV+WeGV82U66vhDLRYC9agOEz7qU1M/mYjWG92EgKqkv
 ArFWSfHcopsOmvwuXEVvTZJ6AVOWxhWrcG71JVk7JEiaj2VxhX3oAYrkw3tMZygm4pGO0EsyB
 uo0FSNLFKNSinyq8n4rdfe/w==

These have been deprecated for a decade[1] and removed two years ago[2].
1: f70486055ee351158bd6999f3965ad378b52c694
2: 2d544ec923dbe5fbed64a7f43dccf527218380bc

Signed-off-by: Stefan Tauner <stefan.tauner@gmx.at>
=2D--
I presume we don't want to keep such obsolete information but sorry for th=
e
noise if we do. Also, I noticed that the original rationale to remove thos=
e
options from ext4 (i.e., no other fs is offering this option) is no longer
valid as others have gained this capability.

 Documentation/admin-guide/ext4.rst | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/Documentation/admin-guide/ext4.rst b/Documentation/admin-guid=
e/ext4.rst
index 5740d85439ff..2418b0c2d3df 100644
=2D-- a/Documentation/admin-guide/ext4.rst
+++ b/Documentation/admin-guide/ext4.rst
@@ -212,16 +212,6 @@ When mounting an ext4 filesystem, the following optio=
n are accepted:
         that ext4's inode table readahead algorithm will pre-read into th=
e
         buffer cache.  The default value is 32 blocks.

-  nouser_xattr
-        Disables Extended User Attributes.  See the attr(5) manual page f=
or
-        more information about extended attributes.
-
-  noacl
-        This option disables POSIX Access Control List support. If ACL su=
pport
-        is enabled in the kernel configuration (CONFIG_EXT4_FS_POSIX_ACL)=
, ACL
-        is enabled by default on mount. See the acl(5) manual page for mo=
re
-        information about acl.
-
   bsddf	(*)
         Make 'df' act like BSD.

=2D-
Kind regards, Stefan Tauner


