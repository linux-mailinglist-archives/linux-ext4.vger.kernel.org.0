Return-Path: <linux-ext4+bounces-11650-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 92819C404D0
	for <lists+linux-ext4@lfdr.de>; Fri, 07 Nov 2025 15:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 941974F2803
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Nov 2025 14:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE3E32AAD7;
	Fri,  7 Nov 2025 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="To2POnNR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A014732938F
	for <linux-ext4@vger.kernel.org>; Fri,  7 Nov 2025 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762525328; cv=none; b=AdQ8tQ+xDQwX5lSWc2nNBAuzPFd3auIiCiNFgMHw1hKiYj6oaHJhECXo2c92FrhD5zAShwwfFyGtp47zyFnAxg/jrWCWcQET+ZWfjGQ2cd8uD+wAFkPfkzHfKf9UTI3trFIgNfikhD42RHZ/ngvUTr5x0IXpvSiDlqk4g0i3bg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762525328; c=relaxed/simple;
	bh=wS2imuQ9BmkOhIkqMvqqB5gl66Z+pbAiZyZ4vNX0hTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JMZUwlyu4r+Q+24P/TNP1NuKP3s8ibSEIGvTkbHx46xvagT7BmR/wlrwGqZj09PnmDhi5MFOL4hiemQV8XZw34gCzvm2Ud060I9kmXHfv+fXZKYIPyj7rgqgMejpn7acQvsNO4DBpqen8LP3Mdc/lhr5Gk1weH5CAhWwEhkZ4+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=To2POnNR; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b72bf7e703fso145655066b.2
        for <linux-ext4@vger.kernel.org>; Fri, 07 Nov 2025 06:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762525324; x=1763130124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALuLKFw+mr0eVU5vuPj8LnIxQt3AfWAYuS4LghXi6Bg=;
        b=To2POnNRLv1Z3RMuB327G2Bf9yjQ9YNRisL8V7Ov15aKZICI4Ofq0UP/LIsjXK3XcJ
         VM/LwdnxjyCrL9PnHBrxhsZCG+NPykzg0l0pv5mRfhqC4hWrY5m+Ozha1bnoZfy6+iYy
         l11vn2RvuaI5l0OjlNCmjYC2kJUYPQzX49GitXv5ByPDkv57UpscjjzZEbRaW9uWdpv+
         mZdwjpZyiDA7wRjBTnWpbImi0ZQl+ClMQo8gZfEUJwOETqt2ZIYoZ3Atbr3xsPzg11Sj
         6Sh9e9DRaAWTOuIlOxUa4w5h6K+nKUNG3PSqzYyCRRclZ8b3LfN9EDfyBN3NIdY6GF7j
         mAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762525324; x=1763130124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ALuLKFw+mr0eVU5vuPj8LnIxQt3AfWAYuS4LghXi6Bg=;
        b=GbGsTBVMjtxP1lxIOoDBeo5CrvjKiYmn9dD09tdqYaDgzMi7kBj7F7tjoSG8plTLqE
         5wiQlWOvWbhtyf0Janb+pHOUtBnLTUE41lyeSmOOiT2q4mtmHxmpxSUXFoJ4JJX9/08L
         4J7lB5IGoTI9hTXpsYhE1Jr3Heb48+cHsJNcQGfaEf9aWZhCVCVGuS5I8js/SBreuGW5
         mCJ9Ms4OG62YB89LE+UZB7q1KsNbD5K7G9lR8FpKJWxN5n7tTOidgtchuAEvwOshHGiJ
         Ius/UJ64bI6QXUPpoB3c1FXcy1u9TIPjQOx1wSjlnS6dEJoVHO1Rx4TOaYGPdtcOiEUu
         zFhw==
X-Forwarded-Encrypted: i=1; AJvYcCVjo5NA7nT9knjhw2OQJQ1mndGJSbX1cI3BOCtukltBpafT2yLEeamGI+xhziJB/DjUxSER5sR0Qg45@vger.kernel.org
X-Gm-Message-State: AOJu0YwyAJjqxhmYJ/YCUoCG404mGyLunQ0J8vyjdPPAp4yLrGlMRLHs
	6kn5Y7Mz/FZaaCPnDDqJkrhDjPEqPN+vIuKzd7PH5VrBTYp19FzkmVVi
X-Gm-Gg: ASbGncuPwcgXCpoUaB79AsYNX+D5hqtj+wnzw+2WpIg53Ws0rsEcTNrMovpKp9HJYzx
	jSL6AFkRcEPMVor1UiMIb8DHlXT/vQIUDCyP65OrCYWx//94t3vhXuPTbxr+F8Ng0BuXTdbgDLt
	0AYm0+Y80lpsY89H1/43Tz8aXZPe/YxIF3KoWdAAqmQffzyVjUaJZjr6XUip2v3lQ9uaqZQsQj9
	Sy5mslZilkwMEFbcVykW95nbgG9VW0lhRS7AFEIPtZw0ODSW4fLU/zbbMXBwCif4V+QhF3hFlE/
	Q3xD/L0s/H+QmGlRSSXakXpNf+c5eiOoxoEGzJU4KlSE5EVkylRTIKesgmNfwBLRchK5AyoMxJy
	o4u0O5AZn+NBQuBQtXlTE4BSDohot3u9RuyxFgiv2lXLm8/p+0ooNmEayiMw0VYYMBc7SCGRi52
	VD27KG+HJW2YdovfgDzzVOq7+iqB2xUxfYBDHKNVRMjmiXuvIz
X-Google-Smtp-Source: AGHT+IFYK2b9ojdXtTAd4PTW5XlFiit6Z3g1OoNfduNaJTNxwuPOLhjJOAV1QVecyGCifhAj28KZcw==
X-Received: by 2002:a17:907:3fa5:b0:b3f:a960:e057 with SMTP id a640c23a62f3a-b72c090e626mr342966366b.31.1762525323963;
        Fri, 07 Nov 2025 06:22:03 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97e563sm253322766b.41.2025.11.07.06.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:22:03 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	torvalds@linux-foundation.org,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 3/3] fs: retire now stale MAY_WRITE predicts in inode_permission()
Date: Fri,  7 Nov 2025 15:21:49 +0100
Message-ID: <20251107142149.989998-4-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107142149.989998-1-mjguzik@gmail.com>
References: <20251107142149.989998-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The primary non-MAY_WRITE consumer now uses lookup_inode_permission_may_exec().

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/namei.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 6b2a5a5478e7..2a112b2c0951 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -546,7 +546,7 @@ static inline int do_inode_permission(struct mnt_idmap *idmap,
  */
 static int sb_permission(struct super_block *sb, struct inode *inode, int mask)
 {
-	if (unlikely(mask & MAY_WRITE)) {
+	if (mask & MAY_WRITE) {
 		umode_t mode = inode->i_mode;
 
 		/* Nobody gets write access to a read-only fs. */
@@ -577,7 +577,7 @@ int inode_permission(struct mnt_idmap *idmap,
 	if (unlikely(retval))
 		return retval;
 
-	if (unlikely(mask & MAY_WRITE)) {
+	if (mask & MAY_WRITE) {
 		/*
 		 * Nobody gets write access to an immutable file.
 		 */
-- 
2.48.1


