Return-Path: <linux-ext4+bounces-2128-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB888A7A55
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Apr 2024 04:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D5641C214C9
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Apr 2024 02:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1B74C8C;
	Wed, 17 Apr 2024 02:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Etk/1xvY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A47979C2
	for <linux-ext4@vger.kernel.org>; Wed, 17 Apr 2024 02:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713319447; cv=none; b=ZJGBbDnS1TB+12p4tvHHm992FnsFZveTiezhRjJ7edR5orOBHLhMu7G7V/nTn+PQ35HYC/1PebQlxlhoXEVA55GHTbwg53xZ6fpVOZdViDG4rLYKx0stBU+HbYMUBP2WxvYxEBIn4yb10yFLYYZWhRNah/i6ctEl95dryODxcF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713319447; c=relaxed/simple;
	bh=7Vu4BLM05UB8isNOTSyilz76Pnlf3a6yF69XeIw4xnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mi6JJ5IMUpWFgNcPE14HQNlKf3Kr77UU1IuxfcaM7fD2IIKrlW+OXDDQu0LG247jWoP6IEXmaesTS5Q62K8bRxDx9cCO7ahpY4YOq0/O1shQmSC75Vkpp3xIwccD9d9bqj/EKOEeZuiR38jLeOgGMgz7Frd6wRM1Ixp7r+u3SAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Etk/1xvY; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 43H23idW013750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 22:03:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1713319426; bh=rRGK71B8f/EjGaAjE6qOAb7usp+7M6oQuhchRdljNTs=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=Etk/1xvYI5zZ3mY7ZLb0kw1H6m+sy2kC8ewWcrDpBbxzdENoLMT/gIOQWYxhermAk
	 PwbEFiGgJoBlQwB21Ww14eVMrGYBYGYUM+cREfzjaJ3EHvCEfV/P9bXJ65cnK0/0X5
	 1EtkDimPGntLcXdfd0aaXAIO1eUjl01fUARdJ420TiSaAMugk9laq8zgBTa2kw0yyJ
	 /TQMkkxx/ljDLueGuA0wS+6jy+2vPBrG6dvsrd+phuekuVZ5R9KVUqJ2LeAU3q3InM
	 YC8cEYhK0FPfA8tWehm1MOLzRLsTz2w8X6C0RkGYchqiRbqo3Lw/8HEOuyKsBMp1yJ
	 jp5o+JePdjk0g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id C5E2A15C0CDC; Tue, 16 Apr 2024 22:03:41 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andreas Dilger <adilger@dilger.ca>,
        "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH e2fsprogs v3 0/4] quota-related e2fsck fixes and tests
Date: Tue, 16 Apr 2024 22:03:35 -0400
Message-ID: <171328638216.2734906.7692057117929527358.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240405142405.12312-1-luis.henriques@linux.dev>
References: <20240405142405.12312-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 05 Apr 2024 15:24:01 +0100, Luis Henriques (SUSE) wrote:
> Changes since v2:
> 
> Added deallocate_inode() documentation, as suggested by Andreas Dilger
> (and using text he provided).
> 
> And, for reference, here's the cover-letter from v2:
> 
> [...]

Applied, thanks!

[1/4] e2fsck: update quota accounting after directory optimization
      commit: eb782652045e67a5379dd319613b0d3d924901dd
[2/4] e2fsck: update quota when deallocating a bad inode
      commit: eb0680deb908d7da399dd331b7aa35cc1a4dfa2d
[3/4] tests: new test to check quota after directory optimization
      commit: 7805308b7a111c3943d92eab412b048d059ce108
[4/4] tests: new test to check quota after a bad inode deallocation
      commit: c6070404a2bed3ff675fc6500828ab6acee985f1

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

