Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C62134ACA6
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Mar 2021 17:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhCZQiL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 26 Mar 2021 12:38:11 -0400
Received: from mx1.hrz.uni-dortmund.de ([129.217.128.51]:58375 "EHLO
        unimail.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhCZQho (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 26 Mar 2021 12:37:44 -0400
Received: from [192.168.111.102] (p4fd97b97.dip0.t-ipconnect.de [79.217.123.151])
        (authenticated bits=0)
        by unimail.uni-dortmund.de (8.16.1/8.16.1) with ESMTPSA id 12QGbYPE001987
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
        Fri, 26 Mar 2021 17:37:35 +0100 (CET)
Subject: Re: [RFC] inode.i_opflags - Usage of two different locking schemes
To:     Jan Kara <jack@suse.cz>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <f63dd495-defb-adc4-aa91-6aacd7f441c7@tu-dortmund.de>
 <a4709bc4-ee62-2cdc-0628-32e8fa73e8f9@tu-dortmund.de>
 <YEJLuP6+Zy8/dq+D@mit.edu>
 <667b3ec3-a522-05a9-31e8-87d8bfaa7adb@tu-dortmund.de>
 <YEJWiXaZ+9H+2nBx@mit.edu>
 <0f387f5b-a516-af45-856d-f38d1adfadf5@tu-dortmund.de>
 <20210316171429.GA22701@quack2.suse.cz>
From:   Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Message-ID: <0e308673-a350-98af-b0a7-cde63abd4579@tu-dortmund.de>
Date:   Fri, 26 Mar 2021 17:37:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210316171429.GA22701@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 16.03.21 18:14, Jan Kara wrote:
> 
> So i_lock is supposed to protect i_opflags for writing AFAICT. For reading
> we don't seem to bother in some cases and I agree that is potentially
> problematic. It is *mostly* OK because we initialize i_opflags when loading
> inode into memory / adding it to dcache. But sometimes we also update them
> while the inode is alive. Now this is fine for the particular flag we
> update but in theory, if the compiler wants to screw us and stores
> temporarily some nonsensical value in i_opflags we'd have a problem. This
> is mostly a theoretical issue but eventually we probably want to fix this.
> 
> 								Honza
> 
Thx for the detailed explanation. :-)

- Alex

-- 
Technische Universität Dortmund
Alexander Lochmann                PGP key: 0xBC3EF6FD
Otto-Hahn-Str. 16                 phone:  +49.231.7556141
D-44227 Dortmund                  fax:    +49.231.7556116
http://ess.cs.tu-dortmund.de/Staff/al
