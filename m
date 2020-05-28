Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010031E63DE
	for <lists+linux-ext4@lfdr.de>; Thu, 28 May 2020 16:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391013AbgE1O0o (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 May 2020 10:26:44 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47150 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390932AbgE1O0o (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 May 2020 10:26:44 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 04SEQdMR023768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 May 2020 10:26:40 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2D941420304; Thu, 28 May 2020 10:26:39 -0400 (EDT)
Date:   Thu, 28 May 2020 10:26:39 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: add casefold flag to EXT4_INODE_* flags
Message-ID: <20200528142639.GA703171@mit.edu>
References: <20200510215252.87833-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510215252.87833-1-ebiggers@kernel.org>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, May 10, 2020 at 02:52:52PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> No one currently needs EXT4_INODE_CASEFOLD, but add it to keep the
> EXT4_INODE_* definitions in sync with the EXT4_*_FL definitions.
> 
> Also make it clearer that the casefold flag is only for directories.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied.

					- Ted
