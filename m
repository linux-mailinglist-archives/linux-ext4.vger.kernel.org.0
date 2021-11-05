Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315BD445F6F
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Nov 2021 06:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbhKEFbD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Nov 2021 01:31:03 -0400
Received: from smtp181.sjtu.edu.cn ([202.120.2.181]:38092 "EHLO
        smtp181.sjtu.edu.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhKEFbC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 Nov 2021 01:31:02 -0400
Received: from proxy02.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
        by smtp181.sjtu.edu.cn (Postfix) with ESMTPS id 03F3C1008CBC1;
        Fri,  5 Nov 2021 13:28:20 +0800 (CST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by proxy02.sjtu.edu.cn (Postfix) with ESMTP id E3CD1200B8923;
        Fri,  5 Nov 2021 13:28:20 +0800 (CST)
X-Virus-Scanned: amavisd-new at 
Received: from proxy02.sjtu.edu.cn ([127.0.0.1])
        by localhost (proxy02.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HAz2J4nohqWJ; Fri,  5 Nov 2021 13:28:20 +0800 (CST)
Received: from [192.168.11.167] (unknown [202.120.40.82])
        (Authenticated sender: sunrise_l@sjtu.edu.cn)
        by proxy02.sjtu.edu.cn (Postfix) with ESMTPSA id F110E200BFDB1;
        Fri,  5 Nov 2021 13:28:10 +0800 (CST)
Subject: Re: [PATCH] ext4: remove unnecessary ext4_inode_datasync_dirty in
 read path
To:     Dave Chinner <david@fromorbit.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingkaidong@gmail.com
References: <20211102024258.210439-1-sunrise_l@sjtu.edu.cn>
 <20211103002843.GC418105@dread.disaster.area>
 <ffb199dc-f7ae-ba03-db57-bf7acc3d0636@sjtu.edu.cn>
 <20211104232226.GD418105@dread.disaster.area>
From:   Zhongwei Cai <sunrise_l@sjtu.edu.cn>
Message-ID: <01e6abf4-3ae5-ecab-3b7f-876c8a3fcbb4@sjtu.edu.cn>
Date:   Fri, 5 Nov 2021 13:28:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211104232226.GD418105@dread.disaster.area>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 11/5/21 7:22 AM, Dave Chinner wrote:
> 
> No. Some filesystems don't track inode metadata dirty status using
> the VFS inode; instead they track it more efficiently in internal
> inode and/or journal based structures. Hence the only way to get
> "inode needs journal flush for data stability" information to
> generic IO code is to have a specific per-IO mapping flag for it.
> 

Could we add IOMAP_REPORT_DIRTY flag in the flags field of
struct iomap_iter to indicate whether the IOMAP_F_DIRTY flag
needs to be set or not?

Currently the IOMAP_F_DIRTY flag is only checked in
iomap_swapfile_activate(), dax_iomap_fault() and iomap_dio_rw()
(To be more specific, only the write path in dax_iomap_fault() and
iomap_dio_rw()). So it would be unnecessary to set the IOMAP_F_DIRTY
flag in dax_iomap_rw() called in the previous tests.

Other file systems that set the IOMAP_F_DIRTY flag efficiently
could ignore the IOMAP_REPORT_DIRTY flag.

Best,

Zhongwei.
