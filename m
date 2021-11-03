Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68456443F58
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Nov 2021 10:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbhKCJZp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Nov 2021 05:25:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49297 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231435AbhKCJZo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Nov 2021 05:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635931387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=74CKwY3wWuqHVEQmjsj7AwvJ1uv1PSv77buzTZzjSnE=;
        b=dLUYYw4iRMDHVnRK+agObLIoIfzZ+eJS0YB8P9Zc01rqYoSx4ZjfK9TEcOtQjA4OWChBiC
        Z6I2xbwRKVBuxOejge22aDznLWFWMFyyAaTJnfEp6LWKGWhp2m80uIa+qhcs25LbTzCro+
        g+OcMJjZ1mUZtDglcZl2S4kUfY6zqOk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-ewY7WNKCPdGYPVeTy-JQSw-1; Wed, 03 Nov 2021 05:23:04 -0400
X-MC-Unique: ewY7WNKCPdGYPVeTy-JQSw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCAF318414A1;
        Wed,  3 Nov 2021 09:23:02 +0000 (UTC)
Received: from work (unknown [10.40.194.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 68914197FC;
        Wed,  3 Nov 2021 09:23:01 +0000 (UTC)
Date:   Wed, 3 Nov 2021 10:22:57 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        Laurent GUERBY <laurent@guerby.net>
Subject: Re: [PATCH v2] ext4: Allow to change s_last_trim_minblks via sysfs
Message-ID: <20211103092257.zmpivrl5yk7kzgx6@work>
References: <20211102141902.9808-1-lczerner@redhat.com>
 <5E30A795-F9C1-4865-8703-75940F918A88@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5E30A795-F9C1-4865-8703-75940F918A88@dilger.ca>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Nov 02, 2021 at 04:44:30PM -0800, Andreas Dilger wrote:
> On Nov 2, 2021, at 06:19, Lukas Czerner <lczerner@redhat.com> wrote:
> > 
> > ﻿Ext4 has an optimization mechanism for batched disacrd (FITRIM) that
> > should help speed up subsequent calls of FITRIM ioctl by skipping the
> > groups that were previously trimmed. However because the FITRIM allows
> > to set the minimum size of an extent to trim, ext4 stores the last
> > minimum extent size and only avoids trimming the group if it was
> > previously trimmed with minimum extent size equal to, or smaller than
> > the current call.
> > 
> > There is currently no way to bypass the optimization without
> > umount/mount cycle. This becomes a problem when the file system is
> > live migrated to a different storage, because the optimization will
> > prevent possibly useful discard calls to the storage.
> > 
> > Fix it by exporting the s_last_trim_minblks via sysfs interface which
> > will allow us to set the minimum size to the number of blocks larger
> > than subsequent FITRIM call, effectively bypassing the optimization.
> > 
> > By setting the s_last_trim_minblks to INT_MAX the optimization will be
> > effectively cleared regardless of the previous state, or file system
> > configuration.
> > 
> > For example:
> > echo 2147483647 > /sys/fs/ext4/dm-1/last_trim_minblks
> > 
> > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> > Reported-by: Laurent GUERBY <laurent@guerby.net>
> 
> The patch itself looks fine, but it isn't really clear why this field is atomic_t?
> There is no particular data integrity needed for this field between threads
> and it is not harmful if it is set or read in a racy manner (at most it is set at
> the end of ext4_trim_fs() once per filesystem trim).

Indeed I was asking myself the same question, but I didn't have the need
to change it. There does not seem to be any good reason for it to be
atomic_t.

> 
> So it seems like this could be a __u32 (like s_clusters_per_group, which is
> the largest possible value it can store)
> and avoid the need to add a new type
> to the sysfs attribute handling?

Sure I can change it. Although the s_clusters_per_group in sbi structure
is unsigned long and that's what we check it against.

Thanks!
-Lukas


> 
> Cheers, Andreas
> 
> 
> > ---
> > v2: Remove unnecessary assignment
> > 
> > fs/ext4/sysfs.c | 13 +++++++++++++
> > 1 file changed, 13 insertions(+)
> > 
> > diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> > index 2314f7446592..94c86eb8d3cc 100644
> > --- a/fs/ext4/sysfs.c
> > +++ b/fs/ext4/sysfs.c
> > @@ -187,6 +187,9 @@ static struct ext4_attr ext4_attr_##_name = {            \
> > #define EXT4_RO_ATTR_SBI_ATOMIC(_name,_elname)    \
> >    EXT4_ATTR_OFFSET(_name, 0444, pointer_atomic, ext4_sb_info, _elname)
> > 
> > +#define EXT4_RW_ATTR_SBI_ATOMIC(_name,_elname)    \
> > +    EXT4_ATTR_OFFSET(_name, 0644, pointer_atomic, ext4_sb_info, _elname)
> > +
> > #define EXT4_ATTR_PTR(_name,_mode,_id,_ptr) \
> > static struct ext4_attr ext4_attr_##_name = {            \
> >    .attr = {.name = __stringify(_name), .mode = _mode },    \
> > @@ -245,6 +248,7 @@ EXT4_ATTR(last_error_time, 0444, last_error_time);
> > EXT4_ATTR(journal_task, 0444, journal_task);
> > EXT4_RW_ATTR_SBI_UI(mb_prefetch, s_mb_prefetch);
> > EXT4_RW_ATTR_SBI_UI(mb_prefetch_limit, s_mb_prefetch_limit);
> > +EXT4_RW_ATTR_SBI_ATOMIC(last_trim_minblks, s_last_trim_minblks);
> > 
> > static unsigned int old_bump_val = 128;
> > EXT4_ATTR_PTR(max_writeback_mb_bump, 0444, pointer_ui, &old_bump_val);
> > @@ -295,6 +299,7 @@ static struct attribute *ext4_attrs[] = {
> > #endif
> >    ATTR_LIST(mb_prefetch),
> >    ATTR_LIST(mb_prefetch_limit),
> > +    ATTR_LIST(last_trim_minblks),
> >    NULL,
> > };
> > ATTRIBUTE_GROUPS(ext4);
> > @@ -474,6 +479,14 @@ static ssize_t ext4_attr_store(struct kobject *kobj,
> >            return ret;
> >        *((unsigned long *) ptr) = t;
> >        return len;
> > +    case attr_pointer_atomic:
> > +        if (!ptr)
> > +            return 0;
> > +        ret = kstrtoint(skip_spaces(buf), 0, (int *)&t);
> > +        if (ret)
> > +            return ret;
> > +        atomic_set((atomic_t *) ptr, t);
> > +        return len;
> >    case attr_inode_readahead:
> >        return inode_readahead_blks_store(sbi, buf, len);
> >    case attr_trigger_test_error:
> > -- 
> > 2.31.1
> > 
> 

