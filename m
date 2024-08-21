Return-Path: <linux-ext4+bounces-3831-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2429095A149
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Aug 2024 17:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5C061F21C62
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Aug 2024 15:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7C11531D7;
	Wed, 21 Aug 2024 15:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="P/4shjX+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021E814F13D;
	Wed, 21 Aug 2024 15:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724253834; cv=none; b=CE7U3aSvmJqLOIJtPhJjN2TOzlhmHSAXrzlypp0w/FCAWS/ivH73iJLNPHTDigWMUNrcN8t2updE0Oe9QH/Wg4nhWgPyFGLLs9MkZY6eKZaJnXh8zO6tkIN9yWJlJD7aZWvuHV5WnxuW3KNI7anG3Ldgp6UkTiPY03B35+9el4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724253834; c=relaxed/simple;
	bh=QyCqOSv9jnU4mFDuKIKKzFt7TqO8NLqQzRkCdd8cDYk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PH30AC2ab0JrWGDAMVYQRv8KbwNv6G0Rdl6G77Vzf+uKZmqOt82npE9tOkEokv0HNhejPuD+XDn8eaDk2xiRwVjC3YwiVSgjLcNDCkeDKwO3VXnQF7rEF+2ICosPJ34KUg5JtLEMSLD88GkaJtTP6npvdltNLZoNCWTREK0hZOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=P/4shjX+; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=6vucnojoH+K+eYi4RGeyyfo5w7jzhfwRCHURdkiioqo=; b=P/4shjX+h+WizWkk8iIGJYrAw5
	y9QYUGOkiFfMSBYXfdPcGCcdcZsn3wIMAPJ5dlh8tWLbcST9UUwZWgRVnhrgSS7oRdNVLtUl9Cbwl
	xCkd9lAzAm4KW4RP5rhnMC+BYi/tlRPbOrBUabptxL1HaAjNeZX+hDq/WHPyjh8SKwThQ6oECmUad
	2HkzySOURHb8usF0ARPicnP2GqbKdalBajOZIGekAel7HpvJy/VI64tCeLSLWtZiV505jczUeL3rw
	0zh0N9jbtZ0m/ZHZ+r6K1J5UyLF+NcBJXUtYffflTJ56iLyvEVxyZNMz7LYkmc0qtJQyHR/iDiaDn
	X3EC7vpw==;
Received: from 179-125-75-209-dinamico.pombonet.net.br ([179.125.75.209] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sgnBf-0034iV-9b; Wed, 21 Aug 2024 17:23:51 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	linux-kernel@vger.kernel.org,
	Tao Ma <boyu.mt@taobao.com>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 3/4] ext4: explicitly exit when ext4_find_inline_entry returns an error
Date: Wed, 21 Aug 2024 12:23:23 -0300
Message-Id: <20240821152324.3621860-4-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821152324.3621860-1-cascardo@igalia.com>
References: <20240821152324.3621860-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__ext4_find_entry currently ignores the return of ext4_find_inline_entry,
except for returning the bh or NULL when has_inline_data is 1.

Even though has_inline_data is set to 1 before calling
ext4_find_inline_entry and would only be set to 0 when that function
returns NULL, check for an encoded error return explicitly in order to
exit.

That makes the code more readable, not requiring that one assumes the cases
when has_inline_data is 1.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/ext4/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 8af437ac3051..14163b32eddb 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1574,7 +1574,7 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
 					     &has_inline_data);
 		if (inlined)
 			*inlined = has_inline_data;
-		if (has_inline_data)
+		if (has_inline_data || IS_ERR(ret))
 			goto cleanup_and_exit;
 	}
 
-- 
2.34.1


