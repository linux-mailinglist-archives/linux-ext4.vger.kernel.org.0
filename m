Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD35C368866
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Apr 2021 23:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239451AbhDVVEG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Apr 2021 17:04:06 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54147 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239483AbhDVVEG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 22 Apr 2021 17:04:06 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 13ML3RKB011390
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Apr 2021 17:03:27 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id EF48815C3B0D; Thu, 22 Apr 2021 17:03:26 -0400 (EDT)
Date:   Thu, 22 Apr 2021 17:03:26 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4] ext4: wipe ext4_dir_entry2 upon file deletion
Message-ID: <YIHknqxngB1sUdie@mit.edu>
References: <20210422180834.2242353-1-leah.rumancik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422180834.2242353-1-leah.rumancik@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Apr 22, 2021 at 06:08:34PM +0000, Leah Rumancik wrote:
> Upon file deletion, zero out all fields in ext4_dir_entry2 besides rec_len.
> In case sensitive data is stored in filenames, this ensures no potentially
> sensitive data is left in the directory entry upon deletion. Also, wipe
> these fields upon moving a directory entry during the conversion to an
> htree and when splitting htree nodes.
> 
> The data wiped may still exist in the journal, but there are future
> commits planned to address this.
> 
> Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>

Applied, thanks.

					- Ted
