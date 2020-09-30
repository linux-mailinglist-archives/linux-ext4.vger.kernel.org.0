Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 396B727F444
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Sep 2020 23:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbgI3Vgo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Sep 2020 17:36:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55326 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgI3Vgn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Sep 2020 17:36:43 -0400
Received: from mail-lf1-f72.google.com ([209.85.167.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mauricio.oliveira@canonical.com>)
        id 1kNjmD-0002IW-B0
        for linux-ext4@vger.kernel.org; Wed, 30 Sep 2020 21:36:41 +0000
Received: by mail-lf1-f72.google.com with SMTP id 140so947132lfk.16
        for <linux-ext4@vger.kernel.org>; Wed, 30 Sep 2020 14:36:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=74i9G+KkCuOQuW/zX7/CXbOVb48eZE6jQA+H3tjDusE=;
        b=PKcsjDVaIo9TeKualoCM6/dxfQQsYcJBs8Jp509/dVBuSrFjaJ5PhIXoLyrAHmPAhc
         r/tiImxngWiv1HkIFEkuYtk3dBMTubFtUzv7pPcKauAY6Gy5P21QGh3hVJpDSTgrMnaa
         0ZQVZ+UgmRgY+wgsQv+PW2hU8w3cJq8FR2gFZ24m8hb4nLo2MZObJSsEyvl4lXakXXga
         OHUqyzeRKPU/FWyURmORjTyNKIsRw5NzdyU2UNredfwT9QRtde66T7T3spjp0pQkL/vH
         uSHbk3QeVAVqiksnGHADgNyqxZgU254mGESwjOd+Jzwv5YYT2j95Fl6EUaCjnNZDlk9d
         qEVQ==
X-Gm-Message-State: AOAM530v9JTymZU3tXz+M4kgfy3RZ1JRsTEzy90QDboGYX06kd+d/uOc
        kitPrMRQ/USUWpQER5OBn3+LEGkzTYI5ubzprCJ6Z0qXSiuOMYGhxxPCzmfH6t8CEnTT8T95HBE
        dtU8/ihBhIvdCltTv1iF5yHwRFA15IhqXD/HTSFys9T1yFyaMqcxIRYw=
X-Received: by 2002:a05:6512:534:: with SMTP id o20mr1398270lfc.397.1601501800355;
        Wed, 30 Sep 2020 14:36:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgR4NUYBNgBFggeujKvPidMtF8htttDtg2bV9Y7VSgt8IOdMYpHtHlqtz0Eifpl5XvejZDRBM72heJn2bRu9c=
X-Received: by 2002:a05:6512:534:: with SMTP id o20mr1398263lfc.397.1601501800138;
 Wed, 30 Sep 2020 14:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200928194103.244692-1-mfo@canonical.com> <20200928194103.244692-2-mfo@canonical.com>
 <2A963475-D65D-4E58-9EDD-93D6784934B4@dilger.ca>
In-Reply-To: <2A963475-D65D-4E58-9EDD-93D6784934B4@dilger.ca>
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
Date:   Wed, 30 Sep 2020 18:36:28 -0300
Message-ID: <CAO9xwp1AUy001ejrNBihodUdwAnQ9qceje+=Ko2nPuabDE9voQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/4] jbd2: introduce/export functions jbd2_journal_submit|finish_inode_data_buffers()
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Sep 28, 2020 at 11:24 PM Andreas Dilger <adilger@dilger.ca> wrote:
>
> On Sep 28, 2020, at 1:41 PM, Mauricio Faria de Oliveira <mfo@canonical.com> wrote:
> >
> > Export functions that implement the current behavior done
> > for an inode in journal_submit|finish_inode_data_buffers().
> >
> > No functional change.
> >
> > Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
> > Suggested-by: Jan Kara <jack@suse.cz>
> > Reviewed-by: Jan Kara <jack@suse.cz>
>
> A couple of minor cleanups below, but either way you could add:
>
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
>

Hey Andreas, thanks for reviewing!

These cleanups/style changes do look better -- applied to the two functions
in patch 1 (submit and finish), and another function in patch 4
(submit callback).

cheers,
Mauricio

> > +int jbd2_journal_finish_inode_data_buffers(struct jbd2_inode *jinode)
> > +{
> > +     struct address_space *mapping = jinode->i_vfs_inode->i_mapping;
> > +     loff_t dirty_start = jinode->i_dirty_start;
> > +     loff_t dirty_end = jinode->i_dirty_end;
> > +     int ret;
> > +
> > +     ret = filemap_fdatawait_range_keep_errors(mapping, dirty_start, dirty_end);
> > +     return ret;
> > +}
>
> (style) still prefer to wrap at 80 columns if possible.
> (style) there isn't any benefit to "dirty_start" and "dirty_end" as locals
> (style) there also isn't any benefit to "ret = ...; return ret"
>
> I thought it might be coded this way because the function is changed in a
> later patch in the series, but I couldn't find anything like that, so the
> shorter form is just as readable, IMHO:
>
> int jbd2_journal_finish_inode_data_buffers(struct jbd2_inode *jinode)
> {
>         struct address_space *mapping = jinode->i_vfs_inode->i_mapping;
>
>         return filemap_fdatawait_range_keep_errors(mapping,
>                                                    jinode->dirty_start,
>                                                    jinode->dirty_end);
> }
>
> Cheers, Andreas
>
>
>
>
>


-- 
Mauricio Faria de Oliveira
