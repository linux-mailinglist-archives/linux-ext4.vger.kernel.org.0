Return-Path: <linux-ext4+bounces-6941-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1C9A6C76E
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Mar 2025 04:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 197DF463509
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Mar 2025 03:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF137083C;
	Sat, 22 Mar 2025 03:36:30 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408B833D8
	for <linux-ext4@vger.kernel.org>; Sat, 22 Mar 2025 03:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742614590; cv=none; b=tmyxc9l0M+O6RrAauM9JN9QWQPwyxI0t1KRMMp+jV6oKp8PJ7xOwUxqATRxoXtAMpcNHu5MikdtuF16IzENOOSDGlX3i/tTzPbbRufCJUzom8Hdo0kSSFeBveSL0Y/BouEoWL2kv/ivxl8NuFDIQKea73vBMDLzMIX2LPw+F6Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742614590; c=relaxed/simple;
	bh=7tSDYaI/CafbrnRherJv5dRogw7AXQVg4/fPvU6hreE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pTuyYRZTzP3Db7HrKZpbqn391uuQT1NEyN5IeXd7dphMUmVtT902HcACe0df8BnXRuaxOxMGNDceyHqDNMH4XijAiny2KekFgTsBSQlFnzrRZO1iWyFN/Gdwqf1T2Y3HUoQ49hnapYKXRrGcAAzaRhDsu39hAMZ34LcStdRK0H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-29.bstnma.fios.verizon.net [173.48.112.29])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52M3aMHq007706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 23:36:23 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id B9C0A2E010C; Fri, 21 Mar 2025 23:36:22 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Nicolas Bretz <bretznic@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [RESEND PATCH] ext4: log rorw on remount only when state changes
Date: Fri, 21 Mar 2025 23:36:15 -0400
Message-ID: <174261457017.1344301.9499531219497060140.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250319171011.8372-1-bretznic@gmail.com>
References: <20250319171011.8372-1-bretznic@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 19 Mar 2025 11:10:11 -0600, Nicolas Bretz wrote:
> it logs ro/rw on remount only when state changes
> removes "Quota mode" as it is obsolete
> 
> Implemented the suggested solutions in:
> https://bugzilla.kernel.org/show_bug.cgi?id=219132
> 
> 
> [...]

Applied, thanks!

[1/1] ext4: log rorw on remount only when state changes
      commit: d7b0befd09320e3356a75cb96541c030515e7f5f

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

