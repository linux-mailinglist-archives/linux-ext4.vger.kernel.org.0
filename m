Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9B3185E87
	for <lists+linux-ext4@lfdr.de>; Sun, 15 Mar 2020 17:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbgCOQnP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Mar 2020 12:43:15 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50639 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728682AbgCOQnP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 15 Mar 2020 12:43:15 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 02FGhAgc029630
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 15 Mar 2020 12:43:11 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9021D420EBA; Sun, 15 Mar 2020 12:43:10 -0400 (EDT)
Date:   Sun, 15 Mar 2020 12:43:10 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 4/7] ext2fs: Implement dir entry creation in htree
 directories
Message-ID: <20200315164310.GR225435@mit.edu>
References: <20200213101602.29096-1-jack@suse.cz>
 <20200213101602.29096-5-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213101602.29096-5-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Feb 13, 2020 at 11:15:59AM +0100, Jan Kara wrote:
> Implement proper creation of new directory entries in htree directories
> in ext2fs_link(). So far we just cleared EXT2_INDEX_FL and treated
> directory as unindexed however this results in mismatched checksums if
> metadata checksums are in use because checksums are placed in different
> places depending on htree node type.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Applied, thanks.

					- Ted
