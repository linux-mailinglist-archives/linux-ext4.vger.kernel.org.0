Return-Path: <linux-ext4+bounces-1375-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A4C8610D5
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Feb 2024 12:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10DDDB21DF8
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Feb 2024 11:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B342E7AE7E;
	Fri, 23 Feb 2024 11:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tH5POp2p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QdmwY6q6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tH5POp2p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QdmwY6q6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5841F5C60F;
	Fri, 23 Feb 2024 11:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708689292; cv=none; b=QIoAWLNnG+3wc0CRREGQpyYckhR0D86QeyIV4LKVc/fgUb9W9iUqpYdpgZCj8J70APVsjr89q1hgJ1XeBGvTaEf/RUavoempWilWIFKbBt8RJWPRGJeg25+lnlAHolfYKBAbVHoTl0QCoUJwDgCgMAoXsJ3WeCPQL2qv2DQ2rS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708689292; c=relaxed/simple;
	bh=hsclevQNjz+SfkH0FkhYEt+qljL99JSIY/InOd4J8vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cuf/H0Xpx82/F8cEyV43wacOtz4khAFgPYxKy9ePBWHRylzAQEgnbe5RTZHNnBpdA/DX2UtPEuNBy5X8PgDpf9mu+yZsf1feFPT77yN0z++oeQR5B6yp26KcpIowmL35TBzAmCdozrydPafnmvthvY83w4u3iI+zco2FpbbZWb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tH5POp2p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QdmwY6q6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tH5POp2p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QdmwY6q6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 17C2A21EF4;
	Fri, 23 Feb 2024 11:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708689288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4jJj4+yHWBRFRCRjCnrlQZ6lYovmQ/EO+kcbsYVVZlE=;
	b=tH5POp2paP8F5tywFW/QXwbb/upYOp8dN703unlSY5BTqoof+p0FLcjJckkq/glA4kfLSX
	6eg55Oawf7hjAbHgCSRoPwWV6Z2S1YuwGcKKVj6sNjdluNPoYN0+R27Fa1SFmHq+08JPYP
	A4OdZYEncu1TNOs+G9BhYC2v+jAbrzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708689288;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4jJj4+yHWBRFRCRjCnrlQZ6lYovmQ/EO+kcbsYVVZlE=;
	b=QdmwY6q6iAr/jDj/DTIwIQyMxcfZpijmyBs8DQwjt1kMQYj/cHRxuyrnh82fOGq1T8+9Ve
	SUTdRvKkThRphSBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708689288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4jJj4+yHWBRFRCRjCnrlQZ6lYovmQ/EO+kcbsYVVZlE=;
	b=tH5POp2paP8F5tywFW/QXwbb/upYOp8dN703unlSY5BTqoof+p0FLcjJckkq/glA4kfLSX
	6eg55Oawf7hjAbHgCSRoPwWV6Z2S1YuwGcKKVj6sNjdluNPoYN0+R27Fa1SFmHq+08JPYP
	A4OdZYEncu1TNOs+G9BhYC2v+jAbrzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708689288;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4jJj4+yHWBRFRCRjCnrlQZ6lYovmQ/EO+kcbsYVVZlE=;
	b=QdmwY6q6iAr/jDj/DTIwIQyMxcfZpijmyBs8DQwjt1kMQYj/cHRxuyrnh82fOGq1T8+9Ve
	SUTdRvKkThRphSBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EEDBC13776;
	Fri, 23 Feb 2024 11:54:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id cRJHOoeH2GVKZAAAn2gu4w
	(envelope-from <jack@suse.cz>); Fri, 23 Feb 2024 11:54:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A59CBA07D1; Fri, 23 Feb 2024 12:54:43 +0100 (CET)
Date: Fri, 23 Feb 2024 12:54:43 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, ritesh.list@gmail.com,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 1/7] ext4: avoid overflow when setting values via sysfs
Message-ID: <20240223115443.spaztzcv7llmfl77@quack3>
References: <20240126085716.1363019-1-libaokun1@huawei.com>
 <20240126085716.1363019-2-libaokun1@huawei.com>
 <20240213160554.35cpsfqqeqpgtux2@quack3>
 <81081ec9-3aab-ecd1-c2f6-9a3835ea4fda@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81081ec9-3aab-ecd1-c2f6-9a3835ea4fda@huawei.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tH5POp2p;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QdmwY6q6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,mit.edu,dilger.ca,gmail.com,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -2.51
X-Rspamd-Queue-Id: 17C2A21EF4
X-Spam-Flag: NO

On Sat 17-02-24 15:09:06, Baokun Li wrote:
> On 2024/2/14 0:05, Jan Kara wrote:
> > On Fri 26-01-24 16:57:10, Baokun Li wrote:
> > > When setting values of type unsigned int through sysfs, we use kstrtoul()
> > > to parse it and then truncate part of it as the final set value, when the
> > > set value is greater than UINT_MAX, the set value will not match what we
> > > see because of the truncation. As follows:
> > > 
> > >    $ echo 4294967296 > /sys/fs/ext4/sda/mb_max_linear_groups
> > >    $ cat /sys/fs/ext4/sda/mb_max_linear_groups
> > >      0
> > > 
> > > So when the value set is outside the variable type range, -EINVAL is
> > > returned to avoid the inconsistency described above. In addition, a
> > > judgment is added to avoid setting s_resv_clusters less than 0.
> > > 
> > > Signed-off-by: Baokun Li <libaokun1@huawei.com>
> > > ---
> > >   fs/ext4/sysfs.c | 4 +++-
> > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> > > index 6d332dff79dd..3671a8aaf4af 100644
> > > --- a/fs/ext4/sysfs.c
> > > +++ b/fs/ext4/sysfs.c
> > > @@ -104,7 +104,7 @@ static ssize_t reserved_clusters_store(struct ext4_sb_info *sbi,
> > >   	int ret;
> > >   	ret = kstrtoull(skip_spaces(buf), 0, &val);
> > > -	if (ret || val >= clusters)
> > > +	if (ret || val >= clusters || (s64)val < 0)
> > >   		return -EINVAL;
> > This looks a bit pointless, doesn't it? 'val' is u64, clusters is u64. We
> > know that val < clusters so how could (s64)val be < 0?
> When clusters is bigger than LLONG_MAX, (s64)val may be less than 0.
> Of course we don't have such a large storage device yet, so it's only
> theoretically possible to overflow here. But the previous patches in this
> patch set were intended to ensure that the values set via sysfs did not
> exceed the range of the variable type, so I've modified that here as well.

Well, my point was that the on disk format is limited to much less than
2^63 blocks. But I guess having the additional check does not matter.

> > > @@ -463,6 +463,8 @@ static ssize_t ext4_attr_store(struct kobject *kobj,
> > >   		ret = kstrtoul(skip_spaces(buf), 0, &t);
> > >   		if (ret)
> > >   			return ret;
> > > +		if (t != (unsigned int)t)
> > > +			return -EINVAL;
> > >   		if (a->attr_ptr == ptr_ext4_super_block_offset)
> > >   			*((__le32 *) ptr) = cpu_to_le32(t);
> > >   		else
> > I kind of agree with Alexey that using kstrtouint() here instead would look
> > nicer. And it isn't like you have to define many new variables. You just
> > need unsigned long for attr_pointer_ul and unsigned int for
> > attr_pointer_ui.
>
> If we use both kstrtouint() and kstrtoul(), then we need to add
> kstrtouint() or kstrtoul() to each case, which would be a lot of
> duplicate code as follows:

Well, it is 5 more lines if I'm counting right :) (3x 3 lines of conversion
- 2x 2 lines of boundary checks). I kind of find it easier to oversee the
boundary checks when everything is together at each parameter. But frankly
this is a bit of nitpicking so if you feel strongly about this I won't
insist.

> static ssize_t ext4_generic_attr_store(struct ext4_attr *a,
>                                        struct ext4_sb_info *sbi,
>                                        const char *buf, size_t len)
> {
>         int ret;
>         unsigned int t;
>         unsigned long lt;
>         void *ptr = calc_ptr(a, sbi);
> 
>         if (!ptr)
>                 return 0;
> 
>         switch (a->attr_id) {
>         case attr_group_prealloc:
>                 ret = kstrtouint(skip_spaces(buf), 0, &t);
>                 if (ret)
>                         return ret;
>                 if (t > sbi->s_clusters_per_group)
>                         return -EINVAL;
>                 return len;
>         case attr_pointer_pi:
>                 ret = kstrtouint(skip_spaces(buf), 0, &t);
>                 if (ret)
>                         return ret;
>                 if ((int)t < 0)
>                         return -EINVAL;
>                 return len;
>         case attr_pointer_ui:
>                 ret = kstrtouint(skip_spaces(buf), 0, &t);
>                 if (ret)
>                         return ret;
>                 if (t != (unsigned int)t)
>                         return -EINVAL;
		  ^^^ this can go away

>                 if (a->attr_ptr == ptr_ext4_super_block_offset)
>                         *((__le32 *) ptr) = cpu_to_le32(t);
>                 else
>                         *((unsigned int *) ptr) = t;
>                 return len;
>         case attr_pointer_ul:
>                 ret = kstrtoul(skip_spaces(buf), 0, &lt);
>                 if (ret)
>                         return ret;
>                 *((unsigned long *) ptr) = lt;
>                 return len;
>         }
>         return 0;
> 
> }
> 
> Also, both kstrtouint() and kstrtoul() are based on the kstrtoull()
> implementation, so it feels better to opencode kstrtoul() and
> kstrtouint() to reduce duplicate code.
> Why is it better to distinguish uint and ulong cases here?

Hopefully explained above :)


								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

