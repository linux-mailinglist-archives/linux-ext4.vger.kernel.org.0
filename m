Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E440841F58A
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Oct 2021 21:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356022AbhJATNT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 1 Oct 2021 15:13:19 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48924 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356015AbhJATNT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 1 Oct 2021 15:13:19 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 4056A1F4594F
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        viro@zeniv.linux.org.uk, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 2/2] fs: ext4: Fix the inconsistent name exposed by
 /proc/self/cwd
Organization: Collabora
References: <cover.1632909358.git.shreeya.patel@collabora.com>
        <8402d1c99877a4fcb152de71005fa9cfb25d86a8.1632909358.git.shreeya.patel@collabora.com>
        <YVdWW0uyRqYWSgVP@mit.edu>
Date:   Fri, 01 Oct 2021 15:11:30 -0400
In-Reply-To: <YVdWW0uyRqYWSgVP@mit.edu> (Theodore Ts'o's message of "Fri, 1
        Oct 2021 14:41:31 -0400")
Message-ID: <8735pk5zml.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

"Theodore Ts'o" <tytso@mit.edu> writes:

> On Wed, Sep 29, 2021 at 04:23:39PM +0530, Shreeya Patel wrote:
>> /proc/self/cwd is a symlink created by the kernel that uses whatever
>> name the dentry has in the dcache. Since the dcache is populated only
>> on the first lookup, with the string used in that lookup, cwd will
>> have an unexpected case, depending on how the data was first looked-up
>> in a case-insesitive filesystem.
>> 
>> Steps to reproduce :-
>> 
>> root@test-box:/src# mkdir insensitive/foo
>> root@test-box:/src# cd insensitive/FOO
>> root@test-box:/src/insensitive/FOO# ls -l /proc/self/cwd
>> lrwxrwxrwx 1 root root /proc/self/cwd -> /src/insensitive/FOO
>> 
>> root@test-box:/src/insensitive/FOO# cd ../fOo
>> root@test-box:/src/insensitive/fOo# ls -l /proc/self/cwd
>> lrwxrwxrwx 1 root root /proc/self/cwd -> /src/insensitive/FOO
>> 
>> Above example shows that 'FOO' was the name used on first lookup here and
>> it is stored in dcache instead of the original name 'foo'. This results
>> in inconsistent name exposed by /proc/self/cwd since it uses the name
>> stored in dcache.
>> 
>> To avoid the above inconsistent name issue, handle the inexact-match string
>> ( a string which is not a byte to byte match, but is an equivalent
>> unicode string ) case in ext4_lookup which would store the original name
>> in dcache using d_add_ci instead of the inexact-match string name.
>
> I'm not sure this is a problem.  /proc/<pid>/cwd just needs to point
> at the current working directory for the process.  Why do we care
> whether it matches the case that was stored on disk?  Whether we use
> /src/insensitive/FOO, or /src/insensitive/Foo, or
> /src/insensitive/foo, all of these will reach the cwd for that
> process.

Hi Ted,

The dcache name is exposed in more places, like /proc/mounts.  We have a
bug reported against flatpak where its initialization code bind mounts a
directory that was previously touched with a different case combination,
and then checks /proc/mounts in a case-sensitive way to see if the mount
succeeded.  This code now regresses on CI directories because the name
it asked to bind mount is not found in /proc/mounts.

Sure, we could figure out the dcache name and pass the current case
spelling of the directory to flatpak, but that could go away at any
time.  We could also make flatpak CI aware, but that problem will just
appear elsewhere.

I think the more reasonable approach is to save the disk exact name on
the dcache, because that is the only version that doesn't change based
on who won the race for the first lookup.

-- 
Gabriel Krisman Bertazi
