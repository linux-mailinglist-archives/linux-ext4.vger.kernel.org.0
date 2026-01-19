Return-Path: <linux-ext4+bounces-12968-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBA5D39CAA
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Jan 2026 04:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF36430011BE
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Jan 2026 03:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17281531C1;
	Mon, 19 Jan 2026 03:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="TDz2mE/3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C1A1FC7
	for <linux-ext4@vger.kernel.org>; Mon, 19 Jan 2026 03:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768791845; cv=none; b=CXRSWoiUkaAA443udrEWG0oEojytTfZ6wp00fymITHZ7Q7HdywuNJD38+U3er3ANM7faWU5YGE56X4Ljw0GTt4CWLTOxrU9wG+wKuGlZlrP7+N63789iz9ePfGRxmMvMcinvhqfG8h8tSTtZD/sk3wn6I/Zo+iEGC2mvMGXbw1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768791845; c=relaxed/simple;
	bh=MICn1z03AAYBfcax9qftbU7vGmmgoqkHOUulbUaA5dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cgu6XViEUjsBJFFzr+m5mg0XKGanLfT/qQs7rvFpC0cfX3lnVyJb/juAeEnF8Jt2skobpoOQ1fWLc0EWjvYAAj8kudGBDMqnkoLlnOJ9q2fzafv9q/ir+FRg0laTaEhB7iB9Dpvfpt5Hv5ceK+jlIRlath/bpElRdImlvJ7TU+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=TDz2mE/3; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([172.56.182.136])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 60J33kwx004300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Jan 2026 22:03:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1768791831; bh=nB54hV7mUJvVAUHH6jkHoM2JbckeEwG9az4bSmh38lU=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=TDz2mE/3KxZ2oRdRnZxUVLxiBObGj7w6nhVZPvloJDdc8Ltt1q0WhwQjG4GGKCXwH
	 qrx2MOkaynS1ZOjYBTHuB14EavbVeP3DSJlhxfiWmGeq8neXpiBPlLEWAvoszbujda
	 kaaaJ0/xs5HQLiTMEo1/6piaf2kswfgfopobtUTXSP2E/G5XpBImypTA6+wCfMdx1Q
	 RqwMgUDQLGkJJ93G4zsc7++JTpqqOz7pditRIzObZkoIrcVyKTZwxWo5lfq+8BoB1p
	 Zv6g5/9Nw3qaCfkjxQoO2NUXTRKQbnoZJG/Noy8z5BEJmp65t5ByCMU8PNNnddDiKq
	 ee0Wbq3T/L1Ag==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 38AC85532B84; Sun, 18 Jan 2026 17:03:12 -1000 (HST)
Date: Sun, 18 Jan 2026 17:03:12 -1000
From: "Theodore Tso" <tytso@mit.edu>
To: Li Chen <me@linux.beauty>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC 5/5] ext4: mark group extend fast-commit ineligible
Message-ID: <20260119030312.GD19954@macsyma.local>
References: <20251211115146.897420-1-me@linux.beauty>
 <20251211115146.897420-6-me@linux.beauty>
 <20260119025857.GC19954@macsyma.local>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119025857.GC19954@macsyma.local>

On Sun, Jan 18, 2026 at 04:58:57PM -1000, Theodore Tso wrote:
> 
> I'm curious what version of the kernel you were testing against?  I
> needed to mnake the final fix up to allow the patch to compile:

Oops, sorry, I replied to the wrong patch.  This fix is relevant to:

       [RFC 3/5] ext4: mark move extents fast-commit ineligible

       	    	       	    	 - Ted
				 

