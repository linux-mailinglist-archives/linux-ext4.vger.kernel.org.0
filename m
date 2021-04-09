Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70B735A8E8
	for <lists+linux-ext4@lfdr.de>; Sat, 10 Apr 2021 00:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbhDIWl4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Apr 2021 18:41:56 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57089 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235046AbhDIWl4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Apr 2021 18:41:56 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 139MfYaG028899
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Apr 2021 18:41:35 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C94B815C3B12; Fri,  9 Apr 2021 18:41:34 -0400 (EDT)
Date:   Fri, 9 Apr 2021 18:41:34 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ye Bin <yebin10@huawei.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] ext4: Fix fs can't panic when abort by user
Message-ID: <YHDYHvV0Cj3wpO28@mit.edu>
References: <20210401081903.3421208-1-yebin10@huawei.com>
 <YHDHFv99m3A6jQjP@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHDHFv99m3A6jQjP@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Apr 09, 2021 at 05:28:54PM -0400, Theodore Ts'o wrote:
> I'll apply the patch with a modified commit description to warn of
> this particular change in behavior.

Applied with the following commit description:

    ext4: always panic when errors=panic is specified
    
    Before commit 014c9caa29d3 ("ext4: make ext4_abort() use
    __ext4_error()"), the following series of commands would trigger a
    panic:
    
    1. mount /dev/sda -o ro,errors=panic test
    2. mount /dev/sda -o remount,abort test
    
    After commit 014c9caa29d3, remounting a file system using the test
    mount option "abort" will no longer trigger a panic.  This commit will
    restore the behaviour immediately before commit 014c9caa29d3.
    (However, note that the Linux kernel's behavior has not been
    consistent; some previous kernel versions, including 5.4 and 4.19
    similarly did not panic after using the mount option "abort".)
    
    This also makes a change to long-standing behaviour; namely, the
    following series commands will now cause a panic, when previously it
    did not:
    
    1. mount /dev/sda -o ro,errors=panic test
    2. echo test > /sys/fs/ext4/sda/trigger_fs_error
    
    However, this makes ext4's behaviour much more consistent, so this is
    a good thing.
    
    Fixes: 014c9caa29d3 ("ext4: make ext4_abort() use __ext4_error()")
    Signed-off-by: Ye Bin <yebin10@huawei.com>
    Link: https://lore.kernel.org/r/20210401081903.3421208-1-yebin10@huawei.com
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

