Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0574D42AACA
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Oct 2021 19:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbhJLRcx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Oct 2021 13:32:53 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36811 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231756AbhJLRcw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Oct 2021 13:32:52 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 19CHUkqM025388
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Oct 2021 13:30:47 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 213D215C00CA; Tue, 12 Oct 2021 13:30:46 -0400 (EDT)
Date:   Tue, 12 Oct 2021 13:30:46 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Avi Deitcher <avi@deitcher.net>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: algorithm for half-md4 used in htree directories
Message-ID: <YWXGRgfxJZMe9iut@mit.edu>
References: <CAF1vpkgPAy3FJ9mN22OVQ41jQAYoRdoCdqzYwRYYPXD4uucdpg@mail.gmail.com>
 <3A493D20-568A-4D63-A575-5DEEBFAAF41A@dilger.ca>
 <CAF1vpkigHMdKphnNjDm7=rR6TTxViHGGHi3bb64rsHG7KbqYzQ@mail.gmail.com>
 <CAF1vpkhwSOfGfErUUrp0YU5hSt58TtykTECiJXTcgqDtG0WVVg@mail.gmail.com>
 <YWSck57bsX/LqAKr@mit.edu>
 <CAF1vpkiKx3jArgjNBrid9-MSHBweGsFL0zu0UgDX_dq_hrkUgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF1vpkiKx3jArgjNBrid9-MSHBweGsFL0zu0UgDX_dq_hrkUgw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Oct 11, 2021 at 07:58:00PM -0700, Avi Deitcher wrote:
> Aha. I missed that the seed is injected into buf before passing it
> into half_md4_transform. I was looking at it as just the empty buffer
> before the first iteration of the loop (or, in my case, since I was
> testing with a 6 char filename, the only iteration).
> 
> I will repeat my experiment with that and see if I can tease it out.

BTW, if you are looking for a userspace implementation of the hash,
it's available in libext2fs in e2fsprogs.

Cheers,

					- Ted
