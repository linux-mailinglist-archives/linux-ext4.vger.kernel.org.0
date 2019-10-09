Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9F1D0A89
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Oct 2019 11:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfJIJJN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Oct 2019 05:09:13 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39632 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfJIJJN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Oct 2019 05:09:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id e1so1002555pgj.6
        for <linux-ext4@vger.kernel.org>; Wed, 09 Oct 2019 02:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/2CUrXw7XGcGK4lh6prcL9SsnSHFpgYxj56Dh9K0z+g=;
        b=qCYCgUqetwF0SaHfnB1vasHMYkLC2n0nF+iuzl7nP6WZcd/sRP0FWYG4d3LUbuJ4Gh
         l+Uthr0kJKlB8T7mDR3AfIqORDufvpWnOIBFbdLU3F6TlyE3YwGquBOhNXwk3Mwk31Yk
         h17oiAr2enqom3iFXzs+pbP6ePknl391r+tPSc4XSvGsVg4hSPcDWBqdMOHYNK2QTw5I
         0hZszJUXWGr9G5GmmLWnmSis67Pfk43SLhKT68I+cbH+LePVNgcw5GNZ8ELkksIA9ZKK
         gprGvIFF7ybVMXVSerZzm6cqhOF0SClEvgsp/cViUATnhoROzJXzyaOnxknHyZc2HF6E
         2vww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/2CUrXw7XGcGK4lh6prcL9SsnSHFpgYxj56Dh9K0z+g=;
        b=BtNRITvzXo9WdVkWvrtlLJX4wtC+c/d+poHS6/95K7FgZnfO/ByXHcYGvea+5HFiCQ
         sXascuFDpxrDIn4Ta4g+9WkP171H7Tk0pNU03d2+e2x3cJFvIEvFOIW6uF4dcMf0HUph
         kgWbWU89RuMvX0fBvm1TeDYtTL7otLBA3whF/Vj7t8RmEAu8mdQzpf8JX7VdVW8d0HDC
         a5iekHXQiBsWP6Gwf6oHR9mAD/qdNfAQNkXjEL1Ut0uz0K2vksYCTGBBWoj6lfIWmFC5
         uCa312X/Zq8UGzsOJvs/wuRwB9DrD+fxtwJvMf0UVMqtQmzFUHdNyPa6FfjUgtSBQQYb
         T64g==
X-Gm-Message-State: APjAAAWEzul20ClfphnjtQwBrnDaG61YK7W/1gaEnRv0dZPMNIYe8r+d
        I21dksEPucT0+rFe/UWlWMYG
X-Google-Smtp-Source: APXvYqyLxk5NmxLppMjRU0bokVzTSlBropM0ly7tfd0bvTL2+Oh1J2ffLSfZ3jt6Zsye2nNtmhyR1Q==
X-Received: by 2002:a17:90a:b38c:: with SMTP id e12mr2855688pjr.114.1570612152588;
        Wed, 09 Oct 2019 02:09:12 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id b14sm1792133pfi.95.2019.10.09.02.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 02:09:11 -0700 (PDT)
Date:   Wed, 9 Oct 2019 20:09:05 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Christoph Hellwig <hch@infradead.org>, tytso@mit.edu, jack@suse.cz,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, david@fromorbit.com,
        darrick.wong@oracle.com
Subject: Re: [PATCH v4 1/8] ext4: move out iomap field population into
 separate helper
Message-ID: <20191009090903.GA2125@poseidon.bobrowski.net>
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
 <8b4499e47bea3841194850e1b3eeb924d87e69a5.1570100361.git.mbobrowski@mbobrowski.org>
 <20191009060255.8055742049@d06av24.portsmouth.uk.ibm.com>
 <20191009070745.GA32281@infradead.org>
 <20191009075018.8BA0A4203F@d06av24.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009075018.8BA0A4203F@d06av24.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 09, 2019 at 01:20:17PM +0530, Ritesh Harjani wrote:
> On 10/9/19 12:37 PM, Christoph Hellwig wrote:
> > On Wed, Oct 09, 2019 at 11:32:54AM +0530, Ritesh Harjani wrote:
> > > We can also get rid of "first_block" argument here.
> > 
> > That would just duplicate filling it out in all callers, so why?
> > 
> 
> What I meant is "first_block" is same as map->m_lblk.
> (unless ext4_map_blocks can change map->m_lblk, which AFAICT, it should
> not).
> So why pass an extra argument when we are already passing 'map'
> structure.
> So we can fill iomap->offset using map->m_lblk in ext4_set_iomap()
> function.

What you're saying makes sense Ritesh and I will update it as such. I
believe what Christoph was actually referring to was what I explained
to Jan to the email that I just sent out. This was around the possible
code duplication and having some iomap value setting related logic
outside ext4_set_iomap(), when in fact there's no real reason why it
can't be inside.

--<M>--

