Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8BBB1C4766
	for <lists+linux-ext4@lfdr.de>; Mon,  4 May 2020 21:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgEDTxA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 May 2020 15:53:00 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48295 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726111AbgEDTxA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 May 2020 15:53:00 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 044JqteM014042
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 May 2020 15:52:56 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id AE03D42085D; Mon,  4 May 2020 15:52:55 -0400 (EDT)
Date:   Mon, 4 May 2020 15:52:55 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jonny Grant <jg@jguk.org>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: /fs/ext4/namei.c ext4_find_dest_de()
Message-ID: <20200504195255.GC404484@mit.edu>
References: <2edc7d6a-289e-57ad-baf1-477dc240474d@jguk.org>
 <20200504015122.GB404484@mit.edu>
 <b518357b-4c79-910a-94dc-b6f0125309bc@jguk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b518357b-4c79-910a-94dc-b6f0125309bc@jguk.org>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, May 04, 2020 at 08:38:33AM +0100, Jonny Grant wrote:
> > > I noticed that mkdir() returns EEXIST if a directory already exists.
> > > strerror(EEXIST) text is "File exists"
> > > 
> > > Can ext4_find_dest_de() be amended to return EISDIR if a directory already
> > > exists? This will make the error message clearer.
> > 
> > No; this will confuse potentially a large number of existing programs.
> > Also, the current behavior is required by POSIx and the Single Unix
> > Specification standards.
> > 
> > 	https://pubs.opengroup.org/onlinepubs/009695399/
> > 
> Is it likely POSIX would introduce this change? It's a shame we're still
> constrained by old standards (SVr4, BSD), but it's fine if they can be
> updated.

No, because it has the potential to break existing Unix/Linux/Posix-compliant
programs.  There may very well be C programs doing the following....

	   if (mkdir(filename) < 0) {
	   	if (errno != EEXIST) {
			perror(filename);
			exit(1);
		}
	}

For example, there may very well be implementations of "mkdir -p" that
do precisely this.

If we change the error returned by the mkdir system call as you
propose, it would break these innocent, unsuspecting programs.  That's
not something which will be allowed, because it falls into the
category of a Bad Thing.

Best regards,

						- Ted
