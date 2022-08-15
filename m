Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8002593111
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Aug 2022 16:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiHOOzw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 15 Aug 2022 10:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiHOOzv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 15 Aug 2022 10:55:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32F514034
        for <linux-ext4@vger.kernel.org>; Mon, 15 Aug 2022 07:55:49 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 73C4A33E47;
        Mon, 15 Aug 2022 14:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660575348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PGqnPqbkhAgPY55E+Ys0ZX5p3B2JBCFMFwlq2saiDJ0=;
        b=VUCDMhHw8IA4QFC3hjVea1NLusbS+UPpAp0iodZjCnGQPEdR+Sk2KxRGi1QXtjQImSp8Sv
        J3gu7Z4xWlUG6cRNUe4E9zdtPjPsueIr/6P3De9aYMXZdLAMKXRzzH7gGbtg7FsTXAuVqD
        vI7hF9JpuvGyYz5WcryFIzhyjAj34dY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660575348;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PGqnPqbkhAgPY55E+Ys0ZX5p3B2JBCFMFwlq2saiDJ0=;
        b=13nAjZPIQCM6Og33awJx1MtjZtKxnavPPv+nj83X4xqMhyyi9UU2LhF9ytY8JhZCZjuBkF
        JZSkDt0aRdpQYCBg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 592712C1C6;
        Mon, 15 Aug 2022 14:55:48 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8F4D3A066A; Mon, 15 Aug 2022 16:55:47 +0200 (CEST)
Date:   Mon, 15 Aug 2022 16:55:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     jack@suse.cz, linux-ext4@vger.kernel.org
Subject: Re: [bug report] ext4: fix race when reusing xattr blocks
Message-ID: <20220815145547.hsufnubt7rgmqnxk@quack3>
References: <YuuLCwthRybOcRPi@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuuLCwthRybOcRPi@kili>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Dan!

On Thu 04-08-22 12:02:03, Dan Carpenter wrote:
> [ This code is above my pay grade.  The cache is refcounted so it might
> not be freed.  But hopefully the patch is recent enough that the details
> are still top of the head for you to review it quickly?  Hopefully, no
> big deal if it's a false positive.  These reports are one time only.
> -dan ]
> 
> Hello Jan Kara,
> 
> The patch 132991ed2882: "ext4: fix race when reusing xattr blocks"
> from Jul 12, 2022, leads to the following Smatch static checker
> warning:
> 
> 	fs/ext4/xattr.c:2038 ext4_xattr_block_set()
> 	warn: 'ea_block_cache' was already freed.

Hum, so I'm not sure why smatch thinks this. The 'ce' entry has been looked
up by ext4_xattr_block_cache_find() and if that function returns entry, it
grabs a reference to that entry which protects 'ce' from being freed. And I
don't see how we could drop the 'ce' reference before reaching that
mb_cache_entry_put() call which is the one smatch complains about. Oh, now
I see it is not complaining about 'ce' entry but rather about
ea_block_cache. That is definitely safe because cache is destroyed only on
unmount / failed mount at which time there should not be other processes
manipulating xattrs on that filesystem. So AFAICT this is a false positive.

								Honza

> 
> fs/ext4/xattr.c
>     1850 static int
>     1851 ext4_xattr_block_set(handle_t *handle, struct inode *inode,
>     1852                      struct ext4_xattr_info *i,
>     1853                      struct ext4_xattr_block_find *bs)
>     1854 {
>     1855         struct super_block *sb = inode->i_sb;
>     1856         struct buffer_head *new_bh = NULL;
>     1857         struct ext4_xattr_search s_copy = bs->s;
>     1858         struct ext4_xattr_search *s = &s_copy;
>     1859         struct mb_cache_entry *ce = NULL;
>     1860         int error = 0;
>     1861         struct mb_cache *ea_block_cache = EA_BLOCK_CACHE(inode);
>     1862         struct inode *ea_inode = NULL, *tmp_inode;
>     1863         size_t old_ea_inode_quota = 0;
>     1864         unsigned int ea_ino;
>     1865 
>     1866 
>     1867 #define header(x) ((struct ext4_xattr_header *)(x))
>     1868 
>     1869         if (s->base) {
>     1870                 int offset = (char *)s->here - bs->bh->b_data;
>     1871 
>     1872                 BUFFER_TRACE(bs->bh, "get_write_access");
>     1873                 error = ext4_journal_get_write_access(handle, sb, bs->bh,
>     1874                                                       EXT4_JTR_NONE);
>     1875                 if (error)
>     1876                         goto cleanup;
>     1877                 lock_buffer(bs->bh);
>     1878 
>     1879                 if (header(s->base)->h_refcount == cpu_to_le32(1)) {
>     1880                         __u32 hash = le32_to_cpu(BHDR(bs->bh)->h_hash);
>     1881 
>     1882                         /*
>     1883                          * This must happen under buffer lock for
>     1884                          * ext4_xattr_block_set() to reliably detect modified
>     1885                          * block
>     1886                          */
>     1887                         if (ea_block_cache) {
>     1888                                 struct mb_cache_entry *oe;
>     1889 
>     1890                                 oe = mb_cache_entry_delete_or_get(ea_block_cache,
>     1891                                         hash, bs->bh->b_blocknr);
> 
> "ea_block_cache" potentially freed here?
> 
>     1892                                 if (oe) {
>     1893                                         /*
>     1894                                          * Xattr block is getting reused. Leave
>     1895                                          * it alone.
>     1896                                          */
>     1897                                         mb_cache_entry_put(ea_block_cache, oe);
> 
> Also here?
> 
>     1898                                         goto clone_block;
>     1899                                 }
>     1900                         }
>     1901                         ea_bdebug(bs->bh, "modifying in-place");
>     1902                         error = ext4_xattr_set_entry(i, s, handle, inode,
>     1903                                                      true /* is_block */);
>     1904                         ext4_xattr_block_csum_set(inode, bs->bh);
>     1905                         unlock_buffer(bs->bh);
>     1906                         if (error == -EFSCORRUPTED)
>     1907                                 goto bad_block;
>     1908                         if (!error)
>     1909                                 error = ext4_handle_dirty_metadata(handle,
>     1910                                                                    inode,
>     1911                                                                    bs->bh);
>     1912                         if (error)
>     1913                                 goto cleanup;
>     1914                         goto inserted;
>     1915                 }
>     1916 clone_block:
>     1917                 unlock_buffer(bs->bh);
>     1918                 ea_bdebug(bs->bh, "cloning");
>     1919                 s->base = kmemdup(BHDR(bs->bh), bs->bh->b_size, GFP_NOFS);
>     1920                 error = -ENOMEM;
>     1921                 if (s->base == NULL)
>     1922                         goto cleanup;
>     1923                 s->first = ENTRY(header(s->base)+1);
>     1924                 header(s->base)->h_refcount = cpu_to_le32(1);
>     1925                 s->here = ENTRY(s->base + offset);
>     1926                 s->end = s->base + bs->bh->b_size;
>     1927 
>     1928                 /*
>     1929                  * If existing entry points to an xattr inode, we need
>     1930                  * to prevent ext4_xattr_set_entry() from decrementing
>     1931                  * ref count on it because the reference belongs to the
>     1932                  * original block. In this case, make the entry look
>     1933                  * like it has an empty value.
>     1934                  */
>     1935                 if (!s->not_found && s->here->e_value_inum) {
>     1936                         ea_ino = le32_to_cpu(s->here->e_value_inum);
>     1937                         error = ext4_xattr_inode_iget(inode, ea_ino,
>     1938                                       le32_to_cpu(s->here->e_hash),
>     1939                                       &tmp_inode);
>     1940                         if (error)
>     1941                                 goto cleanup;
>     1942 
>     1943                         if (!ext4_test_inode_state(tmp_inode,
>     1944                                         EXT4_STATE_LUSTRE_EA_INODE)) {
>     1945                                 /*
>     1946                                  * Defer quota free call for previous
>     1947                                  * inode until success is guaranteed.
>     1948                                  */
>     1949                                 old_ea_inode_quota = le32_to_cpu(
>     1950                                                 s->here->e_value_size);
>     1951                         }
>     1952                         iput(tmp_inode);
>     1953 
>     1954                         s->here->e_value_inum = 0;
>     1955                         s->here->e_value_size = 0;
>     1956                 }
>     1957         } else {
>     1958                 /* Allocate a buffer where we construct the new block. */
>     1959                 s->base = kzalloc(sb->s_blocksize, GFP_NOFS);
>     1960                 error = -ENOMEM;
>     1961                 if (s->base == NULL)
>     1962                         goto cleanup;
>     1963                 header(s->base)->h_magic = cpu_to_le32(EXT4_XATTR_MAGIC);
>     1964                 header(s->base)->h_blocks = cpu_to_le32(1);
>     1965                 header(s->base)->h_refcount = cpu_to_le32(1);
>     1966                 s->first = ENTRY(header(s->base)+1);
>     1967                 s->here = ENTRY(header(s->base)+1);
>     1968                 s->end = s->base + sb->s_blocksize;
>     1969         }
>     1970 
>     1971         error = ext4_xattr_set_entry(i, s, handle, inode, true /* is_block */);
>     1972         if (error == -EFSCORRUPTED)
>     1973                 goto bad_block;
>     1974         if (error)
>     1975                 goto cleanup;
>     1976 
>     1977         if (i->value && s->here->e_value_inum) {
>     1978                 /*
>     1979                  * A ref count on ea_inode has been taken as part of the call to
>     1980                  * ext4_xattr_set_entry() above. We would like to drop this
>     1981                  * extra ref but we have to wait until the xattr block is
>     1982                  * initialized and has its own ref count on the ea_inode.
>     1983                  */
>     1984                 ea_ino = le32_to_cpu(s->here->e_value_inum);
>     1985                 error = ext4_xattr_inode_iget(inode, ea_ino,
>     1986                                               le32_to_cpu(s->here->e_hash),
>     1987                                               &ea_inode);
>     1988                 if (error) {
>     1989                         ea_inode = NULL;
>     1990                         goto cleanup;
>     1991                 }
>     1992         }
>     1993 
>     1994 inserted:
>     1995         if (!IS_LAST_ENTRY(s->first)) {
>     1996                 new_bh = ext4_xattr_block_cache_find(inode, header(s->base),
>     1997                                                      &ce);
>     1998                 if (new_bh) {
>     1999                         /* We found an identical block in the cache. */
>     2000                         if (new_bh == bs->bh)
>     2001                                 ea_bdebug(new_bh, "keeping");
>     2002                         else {
>     2003                                 u32 ref;
>     2004 
>     2005                                 WARN_ON_ONCE(dquot_initialize_needed(inode));
>     2006 
>     2007                                 /* The old block is released after updating
>     2008                                    the inode. */
>     2009                                 error = dquot_alloc_block(inode,
>     2010                                                 EXT4_C2B(EXT4_SB(sb), 1));
>     2011                                 if (error)
>     2012                                         goto cleanup;
>     2013                                 BUFFER_TRACE(new_bh, "get_write_access");
>     2014                                 error = ext4_journal_get_write_access(
>     2015                                                 handle, sb, new_bh,
>     2016                                                 EXT4_JTR_NONE);
>     2017                                 if (error)
>     2018                                         goto cleanup_dquot;
>     2019                                 lock_buffer(new_bh);
>     2020                                 /*
>     2021                                  * We have to be careful about races with
>     2022                                  * adding references to xattr block. Once we
>     2023                                  * hold buffer lock xattr block's state is
>     2024                                  * stable so we can check the additional
>     2025                                  * reference fits.
>     2026                                  */
>     2027                                 ref = le32_to_cpu(BHDR(new_bh)->h_refcount) + 1;
>     2028                                 if (ref > EXT4_XATTR_REFCOUNT_MAX) {
>     2029                                         /*
>     2030                                          * Undo everything and check mbcache
>     2031                                          * again.
>     2032                                          */
>     2033                                         unlock_buffer(new_bh);
>     2034                                         dquot_free_block(inode,
>     2035                                                          EXT4_C2B(EXT4_SB(sb),
>     2036                                                                   1));
>     2037                                         brelse(new_bh);
> --> 2038                                         mb_cache_entry_put(ea_block_cache, ce);
> 
> Warning.
> 
>     2039                                         ce = NULL;
>     2040                                         new_bh = NULL;
>     2041                                         goto inserted;
>     2042                                 }
>     2043                                 BHDR(new_bh)->h_refcount = cpu_to_le32(ref);
>     2044                                 if (ref == EXT4_XATTR_REFCOUNT_MAX)
>     2045                                         ce->e_reusable = 0;
>     2046                                 ea_bdebug(new_bh, "reusing; refcount now=%d",
>     2047                                           ref);
>     2048                                 ext4_xattr_block_csum_set(inode, new_bh);
>     2049                                 unlock_buffer(new_bh);
>     2050                                 error = ext4_handle_dirty_metadata(handle,
>     2051                                                                    inode,
>     2052                                                                    new_bh);
>     2053                                 if (error)
>     2054                                         goto cleanup_dquot;
>     2055                         }
>     2056                         mb_cache_entry_touch(ea_block_cache, ce);
>     2057                         mb_cache_entry_put(ea_block_cache, ce);
>     2058                         ce = NULL;
>     2059                 } else if (bs->bh && s->base == bs->bh->b_data) {
>     2060                         /* We were modifying this block in-place. */
>     2061                         ea_bdebug(bs->bh, "keeping this block");
>     2062                         ext4_xattr_block_cache_insert(ea_block_cache, bs->bh);
>     2063                         new_bh = bs->bh;
>     2064                         get_bh(new_bh);
>     2065                 } else {
>     2066                         /* We need to allocate a new block */
>     2067                         ext4_fsblk_t goal, block;
>     2068 
>     2069                         WARN_ON_ONCE(dquot_initialize_needed(inode));
>     2070 
>     2071                         goal = ext4_group_first_block_no(sb,
>     2072                                                 EXT4_I(inode)->i_block_group);
>     2073 
>     2074                         /* non-extent files can't have physical blocks past 2^32 */
>     2075                         if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)))
>     2076                                 goal = goal & EXT4_MAX_BLOCK_FILE_PHYS;
>     2077 
>     2078                         block = ext4_new_meta_blocks(handle, inode, goal, 0,
>     2079                                                      NULL, &error);
>     2080                         if (error)
>     2081                                 goto cleanup;
>     2082 
>     2083                         if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)))
>     2084                                 BUG_ON(block > EXT4_MAX_BLOCK_FILE_PHYS);
>     2085 
>     2086                         ea_idebug(inode, "creating block %llu",
>     2087                                   (unsigned long long)block);
>     2088 
>     2089                         new_bh = sb_getblk(sb, block);
>     2090                         if (unlikely(!new_bh)) {
>     2091                                 error = -ENOMEM;
>     2092 getblk_failed:
>     2093                                 ext4_free_blocks(handle, inode, NULL, block, 1,
>     2094                                                  EXT4_FREE_BLOCKS_METADATA);
>     2095                                 goto cleanup;
>     2096                         }
>     2097                         error = ext4_xattr_inode_inc_ref_all(handle, inode,
>     2098                                                       ENTRY(header(s->base)+1));
>     2099                         if (error)
>     2100                                 goto getblk_failed;
>     2101                         if (ea_inode) {
>     2102                                 /* Drop the extra ref on ea_inode. */
>     2103                                 error = ext4_xattr_inode_dec_ref(handle,
>     2104                                                                  ea_inode);
>     2105                                 if (error)
>     2106                                         ext4_warning_inode(ea_inode,
>     2107                                                            "dec ref error=%d",
>     2108                                                            error);
>     2109                                 iput(ea_inode);
>     2110                                 ea_inode = NULL;
>     2111                         }
>     2112 
>     2113                         lock_buffer(new_bh);
>     2114                         error = ext4_journal_get_create_access(handle, sb,
>     2115                                                         new_bh, EXT4_JTR_NONE);
>     2116                         if (error) {
>     2117                                 unlock_buffer(new_bh);
>     2118                                 error = -EIO;
>     2119                                 goto getblk_failed;
>     2120                         }
>     2121                         memcpy(new_bh->b_data, s->base, new_bh->b_size);
>     2122                         ext4_xattr_block_csum_set(inode, new_bh);
>     2123                         set_buffer_uptodate(new_bh);
>     2124                         unlock_buffer(new_bh);
>     2125                         ext4_xattr_block_cache_insert(ea_block_cache, new_bh);
>     2126                         error = ext4_handle_dirty_metadata(handle, inode,
>     2127                                                            new_bh);
>     2128                         if (error)
>     2129                                 goto cleanup;
>     2130                 }
>     2131         }
>     2132 
>     2133         if (old_ea_inode_quota)
>     2134                 ext4_xattr_inode_free_quota(inode, NULL, old_ea_inode_quota);
>     2135 
>     2136         /* Update the inode. */
>     2137         EXT4_I(inode)->i_file_acl = new_bh ? new_bh->b_blocknr : 0;
>     2138 
>     2139         /* Drop the previous xattr block. */
>     2140         if (bs->bh && bs->bh != new_bh) {
>     2141                 struct ext4_xattr_inode_array *ea_inode_array = NULL;
>     2142 
>     2143                 ext4_xattr_release_block(handle, inode, bs->bh,
>     2144                                          &ea_inode_array,
>     2145                                          0 /* extra_credits */);
>     2146                 ext4_xattr_inode_array_free(ea_inode_array);
>     2147         }
>     2148         error = 0;
>     2149 
>     2150 cleanup:
>     2151         if (ea_inode) {
>     2152                 int error2;
>     2153 
>     2154                 error2 = ext4_xattr_inode_dec_ref(handle, ea_inode);
>     2155                 if (error2)
>     2156                         ext4_warning_inode(ea_inode, "dec ref error=%d",
>     2157                                            error2);
>     2158 
>     2159                 /* If there was an error, revert the quota charge. */
>     2160                 if (error)
>     2161                         ext4_xattr_inode_free_quota(inode, ea_inode,
>     2162                                                     i_size_read(ea_inode));
>     2163                 iput(ea_inode);
>     2164         }
>     2165         if (ce)
>     2166                 mb_cache_entry_put(ea_block_cache, ce);
>     2167         brelse(new_bh);
>     2168         if (!(bs->bh && s->base == bs->bh->b_data))
>     2169                 kfree(s->base);
>     2170 
>     2171         return error;
>     2172 
>     2173 cleanup_dquot:
>     2174         dquot_free_block(inode, EXT4_C2B(EXT4_SB(sb), 1));
>     2175         goto cleanup;
>     2176 
>     2177 bad_block:
>     2178         EXT4_ERROR_INODE(inode, "bad block %llu",
>     2179                          EXT4_I(inode)->i_file_acl);
>     2180         goto cleanup;
>     2181 
>     2182 #undef header
>     2183 }
> 
> regards,
> dan carpenter
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
