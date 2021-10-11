Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD90429816
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Oct 2021 22:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbhJKUWk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 Oct 2021 16:22:40 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50860 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234867AbhJKUWk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 11 Oct 2021 16:22:40 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 19BKKZLi029752
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 16:20:36 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7057815C00CA; Mon, 11 Oct 2021 16:20:35 -0400 (EDT)
Date:   Mon, 11 Oct 2021 16:20:35 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Avi Deitcher <avi@deitcher.net>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: algorithm for half-md4 used in htree directories
Message-ID: <YWSck57bsX/LqAKr@mit.edu>
References: <CAF1vpkgPAy3FJ9mN22OVQ41jQAYoRdoCdqzYwRYYPXD4uucdpg@mail.gmail.com>
 <3A493D20-568A-4D63-A575-5DEEBFAAF41A@dilger.ca>
 <CAF1vpkigHMdKphnNjDm7=rR6TTxViHGGHi3bb64rsHG7KbqYzQ@mail.gmail.com>
 <CAF1vpkhwSOfGfErUUrp0YU5hSt58TtykTECiJXTcgqDtG0WVVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF1vpkhwSOfGfErUUrp0YU5hSt58TtykTECiJXTcgqDtG0WVVg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Oct 11, 2021 at 08:30:36AM -0700, Avi Deitcher wrote:
> Does someone know how this is constructed and used?
> 
> On Mon, Oct 4, 2021 at 12:57 AM Avi Deitcher <avi@deitcher.net> wrote:
> >
> > Hi Andreas,
> >
> > I had looked in __ext4fs_dirhash(). Yes, it does reference the seed -
> > and create a default if none is there at the filesystem level - but it
> > doesn't appear to use it, in that function. hinfo is populated in the
> > function - hash, minor-hash, seed - but it never uses the seed to
> > manipulate the hash.

The seed is used to initialize the buf array, so long as the seed is
not all zero's.  If it is all zeros, then the default seed is used
instead (right above this bit of code:

	if (hinfo->seed) {
		for (i = 0; i < 4; i++) {
			if (hinfo->seed[i]) {
				memcpy(buf, hinfo->seed, sizeof(buf));
				break;
			}
		}
	}

The legacy hash doesn't use the seed, yes.  But for the other hash
types (hash_version), they mix the filename (in different ways
depending on the hash type.  For example, for half md4:

	case DX_HASH_HALF_MD4:
		p = name;
		while (len > 0) {
			(*str2hashbuf)(p, len, in, 8);
			half_md4_transform(buf, in);
			                   ^^^
			len -= 32;
			p += 32;
		}
		minor_hash = buf[2];
		hash = buf[1];
		break;

When the hash seed is different, that means the initial state of the
buf array will different, and this influences the resulting hash.

Cheers,

					- Ted
