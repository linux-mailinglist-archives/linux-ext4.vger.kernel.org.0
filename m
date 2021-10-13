Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1F642CA5A
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Oct 2021 21:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239064AbhJMTrJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 13 Oct 2021 15:47:09 -0400
Received: from p3plsmtp03-01-2.prod.phx3.secureserver.net ([72.167.218.213]:38221
        "EHLO p3plwbeout03-01.prod.phx3.secureserver.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239091AbhJMTrG (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 13 Oct 2021 15:47:06 -0400
X-Greylist: delayed 469 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Oct 2021 15:47:06 EDT
Received: from mailex.mailcore.me ([94.136.40.143])
        by :WBEOUT: with ESMTP
        id ak3omdY9fAz6Eak3pm5vCu; Wed, 13 Oct 2021 12:37:09 -0700
X-CMAE-Analysis: v=2.4 cv=f9qNuM+M c=1 sm=1 tr=0 ts=61673565
 a=EhJYbXVJKsomWlz4CTV+qA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=8gfv0ekSlNoA:10 a=FXvPX3liAAAA:8
 a=Tqnnkb1RH65CB2acoZsA:9 a=QEXdDO2ut3YA:10 a=SM4aVyO6fsoA:10
 a=UxLD5KG5Eu0A:10 a=OunuuIp3J4_2X_e7vt2U:22 a=fDQtvUcBV1mJc6yKnRhE:22
 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  ak3omdY9fAz6E
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.33])
        by smtp01.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1mak3n-0001YR-Im; Wed, 13 Oct 2021 20:37:07 +0100
Subject: Re: [PATCH 22/29] squashfs: use bdev_nr_sectors instead of open
 coding it
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Song Liu <song@kernel.org>, David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Theodore Ts'o <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Dave Kleikamp <shaggy@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Kees Cook <keescook@chromium.org>, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, reiserfs-devel@vger.kernel.org
References: <20211013051042.1065752-1-hch@lst.de>
 <20211013051042.1065752-23-hch@lst.de>
From:   Phillip Lougher <phillip@squashfs.org.uk>
Message-ID: <cbd3585f-87c6-ab31-2911-4d3550287e22@squashfs.org.uk>
Date:   Wed, 13 Oct 2021 20:37:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211013051042.1065752-23-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfFrZxbO/beudXVK+k348YaOsgLpyM0oiX7vy3T2vdf6cMdxBvuDIJcwDSpUYM46ogkN3S4RImkjKsb8tmqWDCcr5YgjMN/vX4HsIdH3ryVZLh76/+YzJ
 m5tMngzmDjcksMzYOOLrfQkQroaXIGYzCaamU+/zt8cXNEY1OBqKgHzF8pT9PFteDEj1Fztk/eS2s4AzhUCnu2emOt91lLStlqOP/I3qNfhEfRXFNSHr2s+5
 ZSvLnfpIUCQD7nBowOKy6w==
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 13/10/2021 06:10, Christoph Hellwig wrote:
> Use the proper helper to read the block device size.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Phillip Lougher <phillip@squashfs.org.uk>
