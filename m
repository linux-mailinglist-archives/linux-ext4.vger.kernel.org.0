Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4E91BC3C7
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Apr 2020 17:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgD1Pcb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Apr 2020 11:32:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:47244 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727917AbgD1Pcb (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 28 Apr 2020 11:32:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5ED85AB7F;
        Tue, 28 Apr 2020 15:32:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B75B81E1294; Tue, 28 Apr 2020 17:32:28 +0200 (CEST)
Date:   Tue, 28 Apr 2020 17:32:28 +0200
From:   Jan Kara <jack@suse.cz>
To:     Francois <rigault.francois@gmail.com>
Cc:     jack@suse.cz, linux-ext4@vger.kernel.org
Subject: Re: ext4 and project quotas bugs
Message-ID: <20200428153228.GB6426@quack2.suse.cz>
References: <CAMc2VtTqz5QuCfdtEBDND+-sU=7T5_8Sh9Wo-4-u6HbJs+PZdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMc2VtTqz5QuCfdtEBDND+-sU=7T5_8Sh9Wo-4-u6HbJs+PZdw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello!

On Tue 28-04-20 08:41:59, Francois wrote:
> hello! I was just giving ext4 project quotas a try. Definitely not the
> most used ext4 feature (I was the first to answer a stackoverflow
> question on it in https://stackoverflow.com/a/61465057/2852464).
> Quotacheck tells me to mail you the bugs :D so I do

Sure :) Generally for ext4 issues (including project quotas) you can also
ask at linux-ext4@vger.kernel.org (added to CC so that the discussion is
archived for other people).

> my goal is to make some kind of ansible playbook to install project
> quotas, so I am interested in using a tool like setquota, I also want
> the teams behind the capped directories, to think about a clean-up
> mechanism (the quota would just be a temporary annoyance for them), so
> it should not be "jailbreakable" too easily.

Hum, that "not jailbreakable" part is going to be difficult unless you also
confine those users also in their user namespace. Because any user is
allowed to change project ID of the files he owns arbitrarily if he is
running in the initial user namespace. Project quotas have been designed as
an advisory feature back in Irix days... There are talks of allowing to
tweak the behavior (i.e., to allow setting of project id only by sysadmin)
by a mount option but so far nobody has implemented it.

> quota-4.05-3.1.x86_64
> Linux localhost 5.6.2-1-default #1 SMP Thu Apr 2 06:31:32 UTC 2020
> (c8170d6) x86_64 x86_64 x86_64 GNU/Linux
> CPE_NAME="cpe:/o:opensuse:tumbleweed:20200413"
> 
> 1- quotacheck fails with quotacheck: Cannot find filesystem to check
> or filesystem not mounted with quota option.
> prjquota is enabled using extended mount options but quotacheck seems
> to ignore this
> # tune2fs -l /dev/loop0 | grep -i mount\ opt
> Default mount options: user_xattr acl
> Mount options: prjquota
> 
> (also, shouldn't these mount options be reflected in /proc/mounts?)

Yes and that's deliberate. Unlike user and group quotas, project quotas are
only supported when stored in hidden system files (user and group quotas
are also supported in that way when you create ext4 with 'quota' feature).
So checking of quotas is handled by e2fsck and quotacheck has no way to
influence them.

> 2- project quota are a bit too easy to escape:
> dd if=/dev/zero of=someoutput oflag=append
> loop0: write failed, project block limit reached.
> dd: writing to 'someoutput': Disk quota exceeded
> 2467+0 records in
> 2466+0 records out
> 1262592 bytes (1.3 MB, 1.2 MiB) copied, 0.0105432 s, 120 MB/s
> vagrant@localhost:/mnt/loop/abc/mydir3> chattr -p 33 someoutput
> vagrant@localhost:/mnt/loop/abc/mydir3> dd if=/dev/zero of=someoutput
> oflag=append
> dd: writing to 'someoutput': No space left on device
> 127393+0 records in
> 127392+0 records out
> 65224704 bytes (65 MB, 62 MiB) copied, 0.568859 s, 115 MB/s

Yes and as I mentioned above this is deliberate.

> 3- project id '-1" yields fun results:
> 
> chattr +P -p -1 .
> dd if=/dev/zero of=someoutput oflag=append
> dd: failed to open 'someoutput': Invalid argument

Yes, that's a bug that should be fixed. Thanks for reporting this! -1 means
'this id is not expressible in current user namespace' and some code gets
confused along the way. We should refuse to set project -1 for a file...

> 4- setquota fails but return code is zero
> > /usr/sbin/setquota -P 1 2 3 4 5 /dev/loop0 && echo success!
> setquota: Cannot get quota for project 1 from kernel on /dev/loop0:
> Operation not permitted
> setquota: error while getting quota from /dev/loop0 for #1 (id 1):
> Operation not permitted
> success!

OK, so you are unpriviledged user here, aren't you? So the failure is
expected, just the return code is wrong. Do I understand your complaint
correctly? I'm not able to reproduce that error:

nobody@kvm0:/root> /root/source/quota-tools/setquota -P 1 2 3 4 5 /dev/vdb1 && echo success
bash: /root/source/quota-tools/setquota: Permission denied
nobody@kvm0:/root>

Or what exactly are you testing?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
