Return-Path: <linux-ext4+bounces-5009-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E3D9C21AA
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Nov 2024 17:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96D9E1C24D7A
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Nov 2024 16:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321FE126BF7;
	Fri,  8 Nov 2024 16:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="o1eMTM1E"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB80A41
	for <linux-ext4@vger.kernel.org>; Fri,  8 Nov 2024 16:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731082297; cv=none; b=fijoLJU+Fzvios9zQ1L6e9E5Kgc/cjIAtyVQ8fXpDFjziAm2BnT9BPxjPKoVpKkHDHAW98GzVQmctJj7YShZgMt1nUWHjihViweJIH1oKAt5hYO7meAMor7FA34naOW2RCfo743cEO9o1SSbsKAfSQeEQE9FmH6NrwusklLch5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731082297; c=relaxed/simple;
	bh=YDmJxfRIwg7kNKpn66EJfLXtzPFlZHC5qCQ4q2h87Cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFkJDpgYpq4hark7t/sR2pF5mcGgXemKmax1/T9/FZTTRkjekWDRfz9Ibt5dKIrHcurnSlX4lCgE7uEAjzhxg8Xi1bS06utn81fE9JC0C18KvdLbycvgbSjGSzz1Jf18u3m6XjJHgveEK5o1xN3KmYUtbTdIk/jWmqcqgXw0MFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=o1eMTM1E; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-224.bstnma.fios.verizon.net [173.48.82.224])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4A8GBIJe019070
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 8 Nov 2024 11:11:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1731082280; bh=mRP61fWTWZT4triu4FoFnlTUqfqul6lRCzdkOG2p7pk=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=o1eMTM1EEDylMpCeUAPQnlWb+YYYaM7FgNftY0Gl6pfnGS26Se9Z540DF79Oi0DMO
	 uoOEFIZhxGidgdguM0detF7xwS/ZxkBKjT2PzcHONYmT/Jsn/UwHs1fPlUQTQ5R4WX
	 QYVHrGFLuhH7/rynaBXGdeWkQeI2imOo08hUhI03tOt/L8iDgrbtg+F02LsI0WGuI6
	 79F46F95dWLSeW/8+3I6HGw4gpS9xiGcvdlWV4mMGE5Rtj0z8UU0XKEsKM6HMZ7zOt
	 zX0UkAKfwaUERyH6MZx+D7PoeHVkE663TU/Zrt+6dOFGtupQA6OylyH8x2yTcSgZdu
	 DROY0l+CGKKJw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 2161115C02FA; Fri, 08 Nov 2024 11:11:18 -0500 (EST)
Date: Fri, 8 Nov 2024 11:11:18 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: Li Dongyang <dongyangli@ddn.com>, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger@dilger.ca>,
        Alex Zhuravlev <bzzz@whamcloud.com>
Subject: Re: [PATCH V2] jbd2: use rhashtable for revoke records during replay
Message-ID: <20241108161118.GA42603@mit.edu>
References: <20241105034428.578701-1-dongyangli@ddn.com>
 <20241108103358.ziocxsyapli2pexv@quack3>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108103358.ziocxsyapli2pexv@quack3>

On Fri, Nov 08, 2024 at 11:33:58AM +0100, Jan Kara wrote:
> > 1048576 records - 95 seconds
> > 2097152 records - 580 seconds
> 
> These are really high numbers of revoke records. Deleting couple GB of
> metadata doesn't happen so easily. Are they from a real workload or just
> a stress test?

For context, the background of this is that this has been an
out-of-tree that's been around for a very long time, for use with
Lustre servers where apparently, this very large number of revoke
records is a real thing.

> If my interpretation is correct, then rhashtable is unnecessarily
> huge hammer for this. Firstly, as the big hash is needed only during
> replay, there's no concurrent access to the data
> structure. Secondly, we just fill the data structure in the
> PASS_REVOKE scan and then use it. Thirdly, we know the number of
> elements we need to store in the table in advance (well, currently
> we don't but it's trivial to modify PASS_SCAN to get that number).
> 
> So rather than playing with rhashtable, I'd modify PASS_SCAN to sum
> up number of revoke records we're going to process and then prepare
> a static hash of appropriate size for replay (we can just use the
> standard hashing fs/jbd2/revoke.c uses, just with differently sized
> hash table allocated for replay and point journal->j_revoke to
> it). And once recovery completes jbd2_journal_clear_revoke() can
> free the table and point journal->j_revoke back to the original
> table. What do you think?

Hmm, that's a really nice idea; Andreas, what do you think?

     	      	     	  		 - Ted

