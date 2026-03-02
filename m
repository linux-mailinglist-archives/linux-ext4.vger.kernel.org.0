Return-Path: <linux-ext4+bounces-14328-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LgyEgy7pWnNFQAAu9opvQ
	(envelope-from <linux-ext4+bounces-14328-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 17:30:04 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E85E71DCD01
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 17:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B49830776BB
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Mar 2026 16:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735BC30498E;
	Mon,  2 Mar 2026 16:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TigebF+k"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D9D2D0C64
	for <linux-ext4@vger.kernel.org>; Mon,  2 Mar 2026 16:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468501; cv=none; b=cYfbS6Clx6j8v7jOhRoHzhSms1feMDsO0qbCD2Ahdb3sVMC6AqyuLgy5cRZcYHaVS0zEFCmjxDOrxAErJgMD25sjbeGxZO+9CQ//Ks8cfQ8o+yYTuC/oa5/uY/nVVG860Y4GAsXMU4qpTGGeEqzEjnd1rIC7XHNGhynzTSRCf8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468501; c=relaxed/simple;
	bh=XLnJDf16wU+RpuAOUO5MNiJWhJ9cGGNdlu3PjcEwleA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IP+h/6QYkTq82+QqQ84FRi1OqI9IxEvRM8cC0gNWbojsqPWL3qqxgWMlJ3ijQHFnWVFgRKVtG8kaCaL7rloA/fos9VGaVgaQdx97BRiVbS0E1unNK6NCthOM2GshWkDEzPUNZaWdwqLX10Z0gnjsleRStfk45yblhNBx10qaABA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TigebF+k; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2be1d9c356cso584308eec.0
        for <linux-ext4@vger.kernel.org>; Mon, 02 Mar 2026 08:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772468499; x=1773073299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mh5BTNPf22FcAGJyMm54oCFLF78fe9usxjfIafTIqDU=;
        b=TigebF+kZlGpKLbZrmbF30hTLUr4YgvJXyb2yr7uZjicDwP8uQiuiGWAjBtv6V3NAi
         MRiP4Dc4btQcvMe1pF9U57tCiUkztUEzWOCDDCe2YNk6+7cHQwUEl7kA5cCNl3UYzvsc
         qeltIhjCZ/ETOXOQ4FgCbEQyVUN+/2EObzt+TCoh0bxxzG+Zia/h7obzKIFTA/rw1p3/
         b+c1CyONmBf5eFRufT6c4Gg/ZAz9wSYs/btF2Z10YM8vUWgbn32bdgQEsHuYYJqc7hDT
         WtijoZFZG3njpd0YiyOGwilhAP97lxHyJBlMFtkM7ePoOSjLD/kabJqYY/ZNnrk/Eoi4
         mwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772468499; x=1773073299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mh5BTNPf22FcAGJyMm54oCFLF78fe9usxjfIafTIqDU=;
        b=s/RX4TVKWfRmOxNjZiedKPvPG1gHjcQcxwzIcRK8WiXxOmRm/9fmfekjjK6ZwvdTFm
         Riuk6+fjdreUVrgnEdYX5AGkTfRIVgDVggG6N19Z1cZeULqQC28lTAk5SD5zv68KqVBf
         3KnrPKWDhtBYkcvOH18wUGPPgxgp1yi99WuN3jAmqLA4+9SIEmzWT8eJeJgP7UhBBTw/
         k8oKo+Tf/tdQu71QYmSduw6O57na9jZmcbifjOLgE02fco20Auq9OL3AyYZHQDMzKHyl
         PrzP1YdHyDc7EQpKri31ixfpyPC/QwFcqw2iHTXfjmAMGSxRq9+4ciwhsqBMMgUwGofa
         +4jg==
X-Forwarded-Encrypted: i=1; AJvYcCVril789BtSjRo6qOqA0BXdxBHByXfxWNY5lDS3YpldCcYEYzoPCteX86n6UCHuGqczwfkQdz7lCtCY@vger.kernel.org
X-Gm-Message-State: AOJu0YyvrBxqrMeOkUSbQZusxRVVIanp59ELsjnGTnIoYN+tlDxxbvUR
	lz6g7zFdxWwlQzrq6S6eGXc/U9z4dyUzF4PA8G2j6upLjzpdZIQDvjstbQhMGOnb
X-Gm-Gg: ATEYQzyNxUzWK8W1zWozxEInjUpeFN51EwQOKyBbHcjHkbkWi7x4z+UcHRJO6+4MJWp
	gXrE9f0JVn7KQFl5uZdk5ADjC0bieGeV+p1/leeUMWT+IeoIeiSNYiQcPGnoMbEnE7Z7aJ7eOpV
	V/o74tvxzgOSBe02MvhCb3PH1yze3CMQ7hw47d5Y5GRFui1MkdLAHSS1e/4d6/wBF/fY65Afznv
	dCY3RbbhGyNS7eIGWonfFpE8yGVY1Z7qg5lj7CVG1kHP1YBnpJgWikqXXBQ2CgG0qlEJNjhly7P
	gSJ7mkOsAzzNIAZfzlmUSB1LjCJetdlF92FPurXfe20XGFvAwQxml2ZbEyfDeG4UErpaVLgoeOg
	xB1+XRzpt9DcfPxOpUV6cr7lVNN781xNvWJbsJ44wXM8MIYjXrbCMdcZv9IaRmv++sx58OfqEuY
	l9qrPCo27Vc/XlarTuYZnVc564vlhORO3INaMcazz2mNNP/tpqbfdFATRrOsNUfFSqaHNbg+RWP
	cWK1b/YJmIH+n4M0IQNxnO1SgrbKKPELn/UAwn9tN+qn+oVDYbGtoyuBECZHfQuo3ABxD3Bfk7u
	OYQNokiQOP3oHtL7lZqUysr4nFTX
X-Received: by 2002:a05:7300:cb1a:b0:2ba:81b2:7820 with SMTP id 5a478bee46e88-2bde1c99c71mr6387336eec.22.1772468499181;
        Mon, 02 Mar 2026 08:21:39 -0800 (PST)
Received: from arch.lan (c-98-51-119-100.hsd1.ca.comcast.net. [98.51.119.100])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdfed770d4sm5390391eec.17.2026.03.02.08.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 08:21:38 -0800 (PST)
From: Milos Nikic <nikic.milos@gmail.com>
To: jack@suse.cz
Cc: jack@suse.com,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nikic.milos@gmail.com,
	tytso@mit.edu,
	yi.zhang@huaweicloud.com
Subject: Re: [PATCH] jbd2: gracefully abort instead of panicking on unlocked buffer
Date: Mon,  2 Mar 2026 08:21:36 -0800
Message-ID: <20260302162136.38742-1-nikic.milos@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <u4zbebo5va2oxs3ggr5caspz5mklufrfx2rjjg4sw3vhm5d3pw@a5vd7a2ufarh>
References: <u4zbebo5va2oxs3ggr5caspz5mklufrfx2rjjg4sw3vhm5d3pw@a5vd7a2ufarh>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E85E71DCD01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,vger.kernel.org,gmail.com,mit.edu,huaweicloud.com];
	TAGGED_FROM(0.00)[bounces-14328-lists,linux-ext4=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikicmilos@gmail.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Jan,

No, I didn't trigger this in the wild. I have been auditing jbd2 for J_ASSERT usage to see where we could proactively swap hard panics for graceful journal aborts. 

You are right that there are many similar asserts, but I focused on this one because it belongs to a specific, easily-actionable group: it resides in a function that already returns an error code (int). 

Some of the other J_ASSERTs are buried inside void functions. Converting those to return errors would require cascading API changes and rewriting caller error-handling paths across the subsystem, which is a much bigger and riskier lift.

My goal was just to target the "low-hanging fruit" - the asserts where the function signature already supports returning an error (-EINVAL/-EIO) and aborting the journal safely without changing the API.

If you are open to it, I can audit the codebase for the rest of the asserts that fit this exact profile and submit them. Would you prefer them grouped into a single patch, or a short series?

Thanks,
Milos

