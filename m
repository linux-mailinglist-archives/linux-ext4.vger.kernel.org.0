Return-Path: <linux-ext4+bounces-5015-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B27C9C31D0
	for <lists+linux-ext4@lfdr.de>; Sun, 10 Nov 2024 12:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A37F31C20840
	for <lists+linux-ext4@lfdr.de>; Sun, 10 Nov 2024 11:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8FA15624D;
	Sun, 10 Nov 2024 11:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GM4HI/ev"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04D1D2FA;
	Sun, 10 Nov 2024 11:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731238772; cv=none; b=mXtTrIE0AvO9SY1E98ZVhAGb9C8JHiQG8pV7XXAOfYdsin9+NnJ/jRC+kq0AgMX2vStKmUkL6YSbIBxVDa7kW6NdS1mXXULNkvB9p3KwObTOnmwBnOR+ytHSIJkdEWUZxexLpoY0u7WEgOH/wmVgZ5nyZ4T0dMBoMCNaY6CXrfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731238772; c=relaxed/simple;
	bh=PAfZ5x3kwzDZICepgecsaRc/3qCeIXCotdIySrkXH2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOd4bC8gKcXlbtqoVQeJfCZ0YbWAsCQv89Lz75X5V1HehVqEY6yMXcKmukJDV+HXhlU4h6dSIc7Hx5KZJc9dukJ2XRMZwO3k5P64MkwP2npHVo61JMnpySlnNlfZws27De2ZBPoT3XGNrA0jcSaNen4Bza+n729hHycYJOtTKfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GM4HI/ev; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9e8522445dso646305166b.1;
        Sun, 10 Nov 2024 03:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731238769; x=1731843569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xSoh2CyaozoeveWH6+AoChScbb/yq0OX020b2OrI8I=;
        b=GM4HI/evJd9Oh3MjbUSI9dPWdU9ZyByI8jQG2Fcm0O+an1Xw1EsnCQSJ47GS5WRkmT
         87GuvVXCXvHZ1Q7o6MEppU6Oda351qnQC5vWNKYW4M7/Ap6iu4rM9BurSPQW8a/8PDXb
         L4EiVkOstNRuwX2TvG9zxNUxW/rtATno1WzNdzaM/Xj1kIxDxZxTFElUbmRDdmpazjNz
         3GbcrFWydZMSWRdnTC4Djky/clg8CLyKh+gnbgbEtUQN9JPoXIihbtzXHF0cJmirLkR7
         UIvKIeFsQvXPGAvG2XTnjsmtO/4D5lys8iPu++RvP5SGstp4FiL9AcAeOgRS7SOWW4NM
         OfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731238769; x=1731843569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6xSoh2CyaozoeveWH6+AoChScbb/yq0OX020b2OrI8I=;
        b=xN8Zk1ESwxgpUNFlcM/BrgMPsr+Npbzjo1UkB4LLAgM634uDQxMA6jiUeEh5VF93Lx
         XfQ/25TllBIpwyjPoG8+SKc20UK1Lg6GNCMdD5qoxDXuNQxZh5xsjFSL2QtIjXkrrrnR
         3WzNo1DdyJPWb32oriMVTCEuTQkfE/iIDrNvfUnuhzDkwgNVvwM8ZlvCFXyF9LFQ61K7
         uf+jdUnJ8rRaCGH8LloIbCXLuJ23W3Nd5q5QI5kjcRuptm8JhAkuDng1cNkAsHNWqPSE
         LFcnuAdvr78/x2GQHhllI0gqx8cG9XkVRlhrzpTyFuAKXUuSmMY8qPxs7XOnsgNH/6Gr
         MvYg==
X-Forwarded-Encrypted: i=1; AJvYcCVBi2ISKP0VjwWQZk5JrgefWvu745W+1catw1ZoeNfqmDat0NPLfWd59beKstyRp1WbnEKRxoQLF4wAi7gv@vger.kernel.org, AJvYcCWuTuWuy3KQgSjsJG7NjhksWvCAj8AqrNGOk9l3yV62Na5BHjvm9pxOks2bzE13N8E8ykuiBvuqHaZq@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6OGU8xcqYNM6j74q2iHQ+Mr/AvYQvBHTcZWFqXGlIwD6X05rZ
	zyX14SIY2WOf5eKz1dJODBUk1OintSMr2Y7ihhAlAHnObuWx0UsuLu2qN24I
X-Google-Smtp-Source: AGHT+IEJVCC1iXI01Ej6wTgp7o0Yb3WBlTGbkbC1fcFMYR3/GJHUTPmIfkvoDeOfMY3pVMkIGwvPVQ==
X-Received: by 2002:a17:906:f5a3:b0:a99:f833:ca32 with SMTP id a640c23a62f3a-a9eefee8d20mr890383566b.18.1731238768884;
        Sun, 10 Nov 2024 03:39:28 -0800 (PST)
Received: from Max.. ([176.12.185.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0deef3esm468629566b.141.2024.11.10.03.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 03:39:28 -0800 (PST)
From: Max Brener <linmaxi@gmail.com>
To: 
Cc: adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Patch fix suggestion
Date: Sun, 10 Nov 2024 13:37:57 +0200
Message-ID: <20241110113800.17665-1-linmaxi@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: 20241107050307.GA287288@mit.edu
References: 20241016111624.5229-1-linmaxi@gmail.com 20241107050307.GA287288@mit.edu
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Oh okay, I initially thought any preallocation is necessarily done 
through a VFS interface. Now that I see preallocations are done at mballoc,
what I can offer is to clear the TRUNCATED flag at ext4_mb_new_blocks().
Would that be ok in your opinion?


