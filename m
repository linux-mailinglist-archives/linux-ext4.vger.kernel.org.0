Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A28F08A537
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Aug 2019 20:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfHLSBN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Aug 2019 14:01:13 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49625 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726219AbfHLSBN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Aug 2019 14:01:13 -0400
Received: from callcc.thunk.org (guestnat-104-133-9-109.corp.google.com [104.133.9.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7CI16QP027591
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 14:01:08 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6C9184218EF; Mon, 12 Aug 2019 14:01:06 -0400 (EDT)
Date:   Mon, 12 Aug 2019 14:01:06 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2 05/12] jbd2: fast-commit commit path new APIs
Message-ID: <20190812180106.GB28705@mit.edu>
References: <20190809034552.148629-1-harshadshirwadkar@gmail.com>
 <20190809034552.148629-6-harshadshirwadkar@gmail.com>
 <20190812160445.GA28705@mit.edu>
 <CAD+ocbxwraTHT0wPCZgtjC8mJ7OU6wpkd7PgC7_YW=G9W-arDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD+ocbxwraTHT0wPCZgtjC8mJ7OU6wpkd7PgC7_YW=G9W-arDQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 12, 2019 at 10:41:48AM -0700, harshad shirwadkar wrote:
> I see, so you mean each fsync() call will result in exactly one inode
> to be committed (the inode on which fsync was called), right? I agree
> this doesn't need to go through JBD2 but we need a mechanism to inform
> JBD2 about this fast commit since JBD2 maintains sub-transaction ID.
> JBD2 will in turn need to make sure that a subtid was allocated for
> such a fast commit and it was incremented once the fast commit was
> successful as well.

Why does JBD2 need to maintain the sub-transaction ID?  We can only
have a single fast commit happening at a time, and while a fast commit
is happening we can't allow a full commit from happening (or vice
versa).  So we need a mutex which enforces this, the transaction id
can just be a field in the transaction structure.

Cheers,

					- Ted
