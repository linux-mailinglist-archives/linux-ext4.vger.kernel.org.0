Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9619B3BDE68
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jul 2021 22:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhGFUWf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Jul 2021 16:22:35 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54574 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229938AbhGFUWf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Jul 2021 16:22:35 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 166KJpv9003988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Jul 2021 16:19:52 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A4F3915C3CC6; Tue,  6 Jul 2021 16:19:51 -0400 (EDT)
Date:   Tue, 6 Jul 2021 16:19:51 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@whamcloud.com>
Cc:     linux-ext4@vger.kernel.org,
        Artem Blagodarenko <artem.blagodarenko@hpe.com>
Subject: Re: [PATCH] e2fsck: fix ".." more gracefully if possible
Message-ID: <YOS655NZ3MnautMX@mit.edu>
References: <20210531233123.16095-1-adilger@whamcloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531233123.16095-1-adilger@whamcloud.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, May 31, 2021 at 05:31:23PM -0600, Andreas Dilger wrote:
> If the "." entry is corrupted, it will be reset in check_dot().
> It is possible that the ".." entry can be recovered from the
> directory block instead of also resetting it immediately.  If
> it appears that there is a valid ".." entry in the block, allow
> that to be used, and let check_dotdot() verify the dirent itself.
> 
> When resetting the "." and ".." entries, use EXT2_FT_DIR as the
> file type instead of EXT2_FT_UNKNOWN for the very common case of
> filesystems with the "filetype" feature, to avoid later problems
> that can be easily avoided.  This can't always be done, even if
> filesystems without "filetype" are totally obsolete, because many
> old test images do not have this feature enabled.
> 
> Fixup affected tests using the new "repair-test" script that
> updates the expect.[12] files from $test.[12].log for the given
> tests and re-runs the test to ensure it now passes.
> 
> Signed-off-by: Andreas dilger <adilger@whamcloud.com>
> Reviewed-by: Artem Blagodarenko <artem.blagodarenko@hpe.com>
> Lustre-bug-Id: https://jira.whamcloud.com/browse/LU-14710
> Change-Id: Ia5e579bcf31a9d9ee260d5640de6dbdb60514823
> Reviewed-on: https://review.whamcloud.com/43858

Applied, thanks.

					- Ted
