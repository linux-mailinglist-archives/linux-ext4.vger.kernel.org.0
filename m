Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4093EDA0B
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Apr 2019 02:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfD2ALW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 28 Apr 2019 20:11:22 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47517 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726223AbfD2ALW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 28 Apr 2019 20:11:22 -0400
Received: from callcc.thunk.org (adsl-173-228-226-134.prtc.net [173.228.226.134])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x3T0BFDV016077
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Apr 2019 20:11:17 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D788B420023; Sun, 28 Apr 2019 20:11:14 -0400 (EDT)
Date:   Sun, 28 Apr 2019 20:11:14 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] debugfs: avoid ambiguity when printing filenames
Message-ID: <20190429001114.GA555@mit.edu>
References: <20190422202715.167750-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422202715.167750-1-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Apr 22, 2019 at 01:27:15PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The way debugfs escapes filenames is ambiguous because a sequence like
> M-A can mean either the byte 'A' + 128 == 0xc1 or the three bytes
> {'M', '-', 'A'}.  Similarly, ^A can mean either the byte
> 'A' ^ 0x40 == 0x01 or the two bytes {'^', 'A'}.
> 
> Fix this and simplify the code by switching to a simpler strategy where
> all bytes < 32, all bytes >= 127, and backslash are encoded with C-style
> hex escape sequences.  E.g., the byte 0xc1 will now be encoded as \xc1
> rather than M-A as it was before, while a filename consisting of the
> three bytes {'M', '-', 'A'} will continue to be shown as M-A.
> 
> I want to fix this mainly because I want to use debugfs to retrieve raw
> encrypted filenames for ciphertext verification tests.  But this doesn't
> work if the returned filenames are ambiguous.
> 
> Fixes: 68a1de3df340 ("debugfs: pretty print encrypted filenames in the ls command")
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied.

						- Ted
