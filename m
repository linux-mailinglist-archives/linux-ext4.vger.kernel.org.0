Return-Path: <linux-ext4+bounces-12917-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B9ED2F84D
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jan 2026 11:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1EDC303F9A6
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jan 2026 10:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B5831CA46;
	Fri, 16 Jan 2026 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EW6nJ50H"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773AA30AAD4
	for <linux-ext4@vger.kernel.org>; Fri, 16 Jan 2026 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768559139; cv=none; b=ECzoc4BA1p8NvegB/BO13hvtSMvLXe8IP6szUrCDwRFag1uPKQBceK099RinjkjbaybZFIsPzLnsIByQAqtlWWPSHSw7X9kRMoKf4zfAK2BenEJ657Sbk1zhRMvlzyjzSKWl9t9iQ5QKwOIs7pK7/bEREwd4PiD0pfQZS5BldcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768559139; c=relaxed/simple;
	bh=bxKWlgxvvLmzuXEzxRQCwIbMw6J6/JLHRskMD7NHxLk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rHYbyOjLWQ5e/8eIaosY9NcPbcd8+FkjxO1WrXTBVoFx7ae+BXLli0GHsxZ3o0tU/dObdM+1OP4Fragsgd1JEKeZpPWaNmedz5RrGRYWF/PeuUErIIspG7TdDpRp7qapWRA9I9F2aYLVSd1JsI860OYMjiTI/Z0I8/mbxxv0K4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EW6nJ50H; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8c5349ba802so179958385a.1
        for <linux-ext4@vger.kernel.org>; Fri, 16 Jan 2026 02:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768559137; x=1769163937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bxKWlgxvvLmzuXEzxRQCwIbMw6J6/JLHRskMD7NHxLk=;
        b=EW6nJ50H0rXYrRnw515rwiu+KJQMvUN9bL7VoS61LsIuyAEyF0bJb61tbsn7l/N+Mv
         JdNhjt3RNHwYIgYNdEfZHhhoU7vpUVwLqboRLo3gC9aMBMI4EFRnqFfUduYFzxth56ll
         ISteZX2depYnW9n+NxQyliEGuzEvuX0mx4vvRaBXwJDlnto+9TytSkeSEbpxxzGEtoji
         krYClWO/Xxiwo/cf3tB5I0yTAP7XkUXfndBDatWd0G3ofdFLdtwyZdSpeKJhHz0DJBzt
         Kjb0cOkROnYmnXqhkAVthcvTjtqi4QvQhIuezwEsJAFO3h2TiWSXlYcgIiohJQP+dfal
         1GUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768559137; x=1769163937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxKWlgxvvLmzuXEzxRQCwIbMw6J6/JLHRskMD7NHxLk=;
        b=AX54P6M/TPIOpJeBH3/R0O2kVBFayoM+mo22adGxfee8FFRkgh8UtTGtofTUllPKOR
         PXdyhM9ZH/WWOZm5qDjZTXqt3F4QBbhwiY/NYT4g39lc8P29CzmyKTYATfe/riWuOxPK
         lZB35mVdSA8mbxO2Ds8IrBHpWnjtXh3xDXLt79efQXfxevgTrPykv2UjBNwlou8SbSNH
         zcJhGq4DqppPngDTo0Idgzt+n8yNhclo0MRvoDUpCbwkJs1S5v7Qf5easFe8Fkx72oAY
         YQrhnGbnAEe0UDbjCKmmiiQE+V5uJLH+uNlvndSrjRa9quUIO7GnaJxyvUltlYPatxM3
         BHuw==
X-Gm-Message-State: AOJu0Yz4I0Usoi0FF/ny+KK7s22/9xZy4o9c5QlZyZcjIEv7FqGF+k7u
	lXRfOYFWFJq+1Q6CjzedvJczu/mSwiRBDDZpMYdT3VgGwJWCHKXYvfxOAq1cKQ==
X-Gm-Gg: AY/fxX4AEPnluhrzKRDuiQDRPhrELXig1wZPJZsPP/3iJw41yglKJBa0GLHBCfY4+7g
	5Q+r4QLyymvWTQJUG+uYjWQGVf/ePqMb8bsLEQgolfqY1evG3PzOg7SEPEbZzQd9CSfhZV/kD6T
	C/1krShcq7B+tHYAOteCakmxIS3YD4Gf31ITBsCTZCNQ2cqLohIgrNQyGwQvdGCR6pAXBBa8E81
	ZIb/cR+/X3u7LFxIzXl6qVQoF8IDTk5zPNo47Sklns3MGvg+vitRcVp8cRU9Uogzr18aUvA8Jmd
	UaYzD7BDtCkR6hb/T0jwDn/XbUHtVKFUAqvt3H82o2UiXiquwTAMrtr2tKzaILxDudVuEFzfXZ/
	4jtqcGiAnidsN1vfn329bs4PDjzIKXzCWaFrdq0M84k3c+3FmNd/oQpzbVtG2O/iVNi6+ctSVOZ
	kAEcOafWeMC4R6r01jcWJRFng60QMKtX8BPjyoeyQPgV4opEh5Ot+O
X-Received: by 2002:a05:620a:2548:b0:8c5:38ee:2fad with SMTP id af79cd13be357-8c6a67adbaamr316652285a.84.1768559137437;
        Fri, 16 Jan 2026 02:25:37 -0800 (PST)
Received: from daniel-desktop3.localnet ([204.48.77.205])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a7298472sm195765685a.53.2026.01.16.02.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 02:25:36 -0800 (PST)
From: Daniel Tang <danielzgtg.opensource@gmail.com>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Subject: [GIT PULL] e4defrag inline data segfault fix
Date: Fri, 16 Jan 2026 05:25:35 -0500
Message-ID: <4378305.GUtdWV9SEq@daniel-desktop3>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Please sign-off on, and apply, the patch at
https://gist.github.com/tytso/609572aed4d3f789742a50356567e929 . It
fixes the bug at https://github.com/tytso/e2fsprogs/issues/260 .




