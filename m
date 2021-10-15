Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5BD42FC8C
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Oct 2021 21:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242860AbhJOTwr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 Oct 2021 15:52:47 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54894 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S242806AbhJOTwq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 15 Oct 2021 15:52:46 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 19FJobEk008518
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Oct 2021 15:50:37 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D7CCC15C00CA; Fri, 15 Oct 2021 15:50:36 -0400 (EDT)
Date:   Fri, 15 Oct 2021 15:50:36 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Avi Deitcher <avi@deitcher.net>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: algorithm for half-md4 used in htree directories
Message-ID: <YWnbjI9Fo0gKmwS5@mit.edu>
References: <CAF1vpkgPAy3FJ9mN22OVQ41jQAYoRdoCdqzYwRYYPXD4uucdpg@mail.gmail.com>
 <3A493D20-568A-4D63-A575-5DEEBFAAF41A@dilger.ca>
 <CAF1vpkigHMdKphnNjDm7=rR6TTxViHGGHi3bb64rsHG7KbqYzQ@mail.gmail.com>
 <CAF1vpkhwSOfGfErUUrp0YU5hSt58TtykTECiJXTcgqDtG0WVVg@mail.gmail.com>
 <YWSck57bsX/LqAKr@mit.edu>
 <CAF1vpkiKx3jArgjNBrid9-MSHBweGsFL0zu0UgDX_dq_hrkUgw@mail.gmail.com>
 <YWXGRgfxJZMe9iut@mit.edu>
 <CAF1vpkggQpYrg7Z2VVK69pPBo0rSjDUsm8nB8dyES27cmDEf2g@mail.gmail.com>
 <YWnSMXcR5anaYTEU@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWnSMXcR5anaYTEU@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Oh, and taking a quick look at your program, here's at least one of
the bugs:

static void calculate(char *name) {
                      ^^^^^^^^^^
...
    __ext4fs_dirhash(name, sizeof(name), &hinfo);
                           ^^^^^^^^^^^^

With apologies to the movie "The Princess Bride"[1]:

    You fell victim to one of the classic blunders!  The most famous
    is to never get involved in a land war in Asia, but only slightly
    less well-known is this: 'taking the size of a C pointer is
    generally not what you had wanted to do'!  :-)

[1] https://www.youtube.com/watch?v=R7TFPQqglb4

    	  	    	       - Ted
