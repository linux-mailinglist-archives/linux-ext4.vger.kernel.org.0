Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7A9E8AA51
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Aug 2019 00:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfHLWUa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Aug 2019 18:20:30 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37518 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726488AbfHLWU3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Aug 2019 18:20:29 -0400
Received: from callcc.thunk.org (guestnat-104-133-9-109.corp.google.com [104.133.9.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7CMK4AQ010100
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 18:20:06 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id F054A4218EF; Mon, 12 Aug 2019 18:20:03 -0400 (EDT)
Date:   Mon, 12 Aug 2019 18:20:03 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
        linux-api@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Paul Crowley <paulcrowley@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v8 05/20] fscrypt: rename fscrypt_master_key to
 fscrypt_direct_key
Message-ID: <20190812222003.GD28705@mit.edu>
References: <20190805162521.90882-1-ebiggers@kernel.org>
 <20190805162521.90882-6-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805162521.90882-6-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 05, 2019 at 09:25:06AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> In preparation for introducing a filesystem-level keyring which will
> contain fscrypt master keys, rename the existing 'struct
> fscrypt_master_key' to 'struct fscrypt_direct_key'.  This is the
> structure in the existing table of master keys that's maintained to
> deduplicate the crypto transforms for v1 DIRECT_KEY policies.
> 
> I've chosen to keep this table as-is rather than make it automagically
> add/remove the keys to/from the filesystem-level keyring, since that
> would add a lot of extra complexity to the filesystem-level keyring.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good.  You can add:

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

						- Ted
