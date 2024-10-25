Return-Path: <linux-ext4+bounces-4745-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2009AF87F
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Oct 2024 05:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 724631F21969
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Oct 2024 03:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E7518C025;
	Fri, 25 Oct 2024 03:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="aI0knvfU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9DC433BE
	for <linux-ext4@vger.kernel.org>; Fri, 25 Oct 2024 03:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729828445; cv=none; b=ZTPAw4624MAakNcWJk4wBu/BAwxJH1lGrvM46SeLn5lE6GmnB7URggXVj6uew+Rbw7HDrq9tmXUXIRlSiiwcnqkyHXdzYvSSN6c7or/4fra9rxqzbNMWGsVI0cUJuh0cJwC7lG+LEFzx2X/mu3KHSE3/VMxVeAv/756c/TygH2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729828445; c=relaxed/simple;
	bh=7EuiUq5k5FlSKJagnmVyrw8rB8v2iHocmDKJ/4dobl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EDJr5JHab0A2HZm6LjJ36pAxzOeJ1ob+UU21rWLQshnMDs4z8PR9LgyAbVLO2K4+8okkgGoBc46/p4vQ2rnt57NChxDHtFymi364FMnQGC8r4vquJwJtwOSiA04UIWzqgm8MYHtuFIcx1G7Oo3Zp/2G9mafOY6orYHIVj0c78/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=aI0knvfU; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-115-113.bstnma.fios.verizon.net [173.48.115.113])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 49P3rvir027478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 23:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1729828440; bh=qaiYYma5NRcG8ZeNrHd001CeTFSSb9JE+1D5frVRGxA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=aI0knvfUYKu+L0O3YVCp+5T0YzLXsx14Tt+rtgaTdGyrG3BLFeOOF6auYkrdWeoEM
	 vDi3kWg21jkHiSuW9oWZgkDM4WZK43riniBHqBryisjaJWhd/9cLSLNMY5cur7mY2U
	 2w5wmCFomXlSqrzRgxzpShrRfL2tYXx2GFTPr8LNwqfh8tPbLsFx6rYaA6shv9aDO/
	 6YkXVHELQkjqHSl8ANCcyI0hgOn64L7JyXwfGpGGKz0tuf0+FPwJdsQPM92b47sePl
	 4qwd7X9phd8+PSf5+Ds840Su7zX+SmlkG5jzPs1gPJZa80KaAnO3qF9LY4zXRTmbES
	 Wh4XAJLi/ligA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id A2C8415C0329; Thu, 24 Oct 2024 23:53:57 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger@dilger.ca>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] tests: write f_badjour_encrypted output to log
Date: Thu, 24 Oct 2024 23:53:45 -0400
Message-ID: <172982841322.4001088.5093484687711589094.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240605200408.55221-1-adilger@dilger.ca>
References: <20240605200408.55221-1-adilger@dilger.ca>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 05 Jun 2024 14:03:52 -0600, Andreas Dilger wrote:
> Write the mke2fs and debugfs output from f_badjour_encrypted/script
> into a log file instead of stdout/stderr, so that it doesn't mess
> up the "make check" output, and is available if this test ever fails.
> 
> 

Applied, thanks!

[1/1] tests: write f_badjour_encrypted output to log
      commit: 5cf2c6b1df44e5ef145a5af8e6317ad87b190500

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

