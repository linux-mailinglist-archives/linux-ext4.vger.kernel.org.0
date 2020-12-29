Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1092E74FC
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Dec 2020 23:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgL2WZH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 29 Dec 2020 17:25:07 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35386 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726138AbgL2WZH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 29 Dec 2020 17:25:07 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0BTMO6Dm006244
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Dec 2020 17:24:07 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3200D15C34A8; Tue, 29 Dec 2020 17:24:06 -0500 (EST)
Date:   Tue, 29 Dec 2020 17:24:06 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     yangerkun <yangerkun@huawei.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, lihaotian9@huawei.com, lutianxiong@huawei.com,
        linfeilong@huawei.com
Subject: Re: [PATCH v2] ext4: fix bug for rename with RENAME_WHITEOUT
Message-ID: <X+ushgURuSXY4Lz9@mit.edu>
References: <20201229090208.1113218-1-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201229090208.1113218-1-yangerkun@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Dec 29, 2020 at 05:02:08PM +0800, yangerkun wrote:
> ext4_rename will create a special inode for whiteout and use this 'ino'
> to replace the source file's dir entry 'ino'. Once error happens
> latter(small ext4 img, and consume all space, so the rename with dst
> path not exist will fail due to the ENOSPC return from ext4_add_entry in
> ext4_rename), the cleanup do drop the nlink for whiteout, but forget to
> restore 'ino' with source file. This will lead to "deleted inode
> referenced".

Could you sendhave instructions how to reproduce this failure?  Many thanks!!

      	  	   		    - Ted
