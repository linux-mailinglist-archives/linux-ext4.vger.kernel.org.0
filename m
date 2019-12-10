Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABA73118479
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Dec 2019 11:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfLJKKT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Dec 2019 05:10:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:44322 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727016AbfLJKKT (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 10 Dec 2019 05:10:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 14922B12D;
        Tue, 10 Dec 2019 10:10:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5B51D1E0B23; Tue, 10 Dec 2019 11:10:17 +0100 (CET)
Date:   Tue, 10 Dec 2019 11:10:17 +0100
From:   Jan Kara <jack@suse.cz>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.com,
        adilger.kernel@dilger.ca
Subject: Re: [Q] e4defrag and append-only files
Message-ID: <20191210101017.GD1551@quack2.suse.cz>
References: <a2b2fcf4-4b71-e78c-5a10-627097df44fb@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2b2fcf4-4b71-e78c-5a10-627097df44fb@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi!

On Mon 09-12-19 13:54:24, Kirill Tkhai wrote:
> on one of production nodes I observe the situation, when many fragmented files
> never become defragmented, becase of they have "a" extended attribute.
> The reason is append-only file can't be open for write without O_APPEND attribute:
> 
> $lsattr a.txt
> -----a--------e----- a.txt
> 
> $strace e4defrag a.txt
> openat(AT_FDCWD, "a.txt", O_RDWR)       = -1 EPERM (Operation not permitted)
> 
> Simple O_APPEND passed to open() solves the situation.
> 
> The question is: can't we just do this?
> 
> Let's observe the file restrictions we may have.
> 
> "Append-only" extended attribute restriction is weaker, than RO file permissions (0444).
> But RO files are being processed by e4defrag, since e4defrag runs by root, and it easily
> ignores RO file permissions, while "append-only" files are always ignored by the util.
> Is there a fundamental reason we must skip them?

I don't think there's a technical reason why we cannot defragment inodes
with 'append-only' or even 'immutable' attribute. Just e4defrag would have
to remove these flags so that open can succeed (because neither append-only
nor immutable flags are overridden by CAP_DAC_OVERRIDE capability - unlike
standard unix permissions or xattrs) and then restore the flags after the
fact.

Whether we really want to do this is another question. I don't think
e4defrag should touch immutable files, for append-only files I don't have a
strong opinion...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
